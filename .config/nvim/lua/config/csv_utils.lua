local function get_card_brand(card)
  if card:match('^3[47]') then return 'Amex'
  elseif card:match('^606282') or card:match('^637095') then return 'Hipercard'
  elseif card:match('^6362') or card:match('^438935') or card:match('^4576') or card:match('^4011') or card:match('^5067') then return 'Elo'
  elseif card:match('^6011') or card:match('^65') then return 'Discover'
  elseif card:match('^5[1-5]') then return 'Mastercard'
  elseif card:match('^4') then return 'Visa'
  else return 'Unknown'
  end
end

local function extract_card(line)
  return line:match('%d%d%d%d%d%d%d%d%d%d%d%d%d%d+')
end

local function extract_expiry(line)
  local month, year = line:match('|(%d%d?)|(%d%d%d%d)|')
  return tonumber(month), tonumber(year)
end

-- Replace all semicolons with pipes
vim.api.nvim_create_user_command('ParseIntoPipes', function()
  vim.cmd([[silent! %s/;/|/g]])
end, { desc = 'CSV: replace ; with |' })

-- Pad month to 2 digits: anchored before 4-digit year (20xx)
vim.api.nvim_create_user_command('ParseMonthDate', function()
  vim.cmd([[silent! %s/|\([1-9]\)|\(20[0-9][0-9]\)|/|0\1|\2|/g]])
end, { desc = 'CSV: pad month to 2 digits using year anchor' })

-- Pad CVV to 3 digits: anchored after 4-digit year (20xx)
vim.api.nvim_create_user_command('ParseCVV', function()
  vim.cmd([[silent! %s/|\(20[0-9][0-9]\)|\([0-9]\{2\}\)|/|\1|0\2|/g]])
  vim.cmd([[silent! %s/|\(20[0-9][0-9]\)|\([0-9]\)|/|\1|00\2|/g]])
end, { desc = 'CSV: pad CVV to 3 digits using year anchor' })

-- Remove last column
vim.api.nvim_create_user_command('RemoveLastColumn', function()
  vim.cmd([[silent! %s/|[^|]*$//g]])
end, { desc = 'CSV: remove last column' })

-- Remove duplicate lines by card number (first 14+ digit sequence)
vim.api.nvim_create_user_command('RemoveDuplicatesByCard', function()
  local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
  local seen = {}
  local result = {}
  for _, line in ipairs(lines) do
    local card = extract_card(line)
    if card then
      if not seen[card] then
        seen[card] = true
        table.insert(result, line)
      end
    else
      table.insert(result, line)
    end
  end
  local removed = #lines - #result
  vim.api.nvim_buf_set_lines(0, 0, -1, false, result)
  vim.notify('RemoveDuplicatesByCard: ' .. removed .. ' duplicates removed')
end, { desc = 'CSV: remove duplicate lines by card number' })

-- Remove expired cards based on current system date
vim.api.nvim_create_user_command('RemoveExpired', function()
  local current_year = tonumber(os.date('%Y'))
  local current_month = tonumber(os.date('%m'))
  local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
  local result = {}
  for _, line in ipairs(lines) do
    local card = extract_card(line)
    if not card then
      table.insert(result, line)
    else
      local month, year = extract_expiry(line)
      if year and month then
        if year > current_year or (year == current_year and month >= current_month) then
          table.insert(result, line)
        end
      else
        table.insert(result, line)
      end
    end
  end
  local removed = #lines - #result
  vim.api.nvim_buf_set_lines(0, 0, -1, false, result)
  vim.notify('RemoveExpired: ' .. removed .. ' expired cards removed')
end, { desc = 'CSV: remove cards expired before today' })

-- Show stats: total cards, by brand, expired count
vim.api.nvim_create_user_command('CardStats', function()
  local current_year = tonumber(os.date('%Y'))
  local current_month = tonumber(os.date('%m'))
  local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
  local total = 0
  local expired = 0
  local brands = {}
  for _, line in ipairs(lines) do
    local card = extract_card(line)
    if card then
      total = total + 1
      local brand = get_card_brand(card)
      brands[brand] = (brands[brand] or 0) + 1
      local month, year = extract_expiry(line)
      if year and month then
        if year < current_year or (year == current_year and month < current_month) then
          expired = expired + 1
        end
      end
    end
  end
  local msg = 'Total: ' .. total .. '  |  Expired: ' .. expired .. '\n'
  for brand, count in pairs(brands) do
    msg = msg .. brand .. ': ' .. count .. '\n'
  end
  vim.notify(msg, vim.log.levels.INFO)
end, { desc = 'CSV: show card stats by brand and expiry' })

-- Filter to keep only cards of a specific brand (e.g. :FilterCardBrand Visa)
vim.api.nvim_create_user_command('FilterCardBrand', function(opts)
  local target = opts.args
  if target == '' then
    vim.notify('Usage: :FilterCardBrand Visa|Mastercard|Amex|Elo|Hipercard|Discover', vim.log.levels.WARN)
    return
  end
  local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
  local result = {}
  for _, line in ipairs(lines) do
    local card = extract_card(line)
    if not card then
      table.insert(result, line)
    elseif get_card_brand(card) == target then
      table.insert(result, line)
    end
  end
  vim.api.nvim_buf_set_lines(0, 0, -1, false, result)
  vim.notify('FilterCardBrand: kept ' .. (#result - 1) .. ' ' .. target .. ' cards')
end, { nargs = 1, desc = 'CSV: keep only cards of given brand' })

-- Sort lines by expiry date (year then month), header stays on top
vim.api.nvim_create_user_command('SortByExpiry', function()
  local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
  local header = nil
  local data = {}
  for _, line in ipairs(lines) do
    if extract_card(line) then
      table.insert(data, line)
    else
      header = line
    end
  end
  table.sort(data, function(a, b)
    local ma, ya = extract_expiry(a)
    local mb, yb = extract_expiry(b)
    ya, ma = ya or 0, ma or 0
    yb, mb = yb or 0, mb or 0
    if ya ~= yb then return ya < yb end
    return ma < mb
  end)
  local result = {}
  if header then table.insert(result, header) end
  for _, line in ipairs(data) do table.insert(result, line) end
  vim.api.nvim_buf_set_lines(0, 0, -1, false, result)
  vim.notify('SortByExpiry: sorted ' .. #data .. ' cards')
end, { desc = 'CSV: sort cards by expiry date ascending' })

-- Uppercase all holder names (text after last pipe)
vim.api.nvim_create_user_command('NormalizeHolderName', function()
  vim.cmd([[silent! %s/|\([^|]*\)$/|\U\1/g]])
end, { desc = 'CSV: uppercase holder names' })

-- Distribution of cards by expiry year
vim.api.nvim_create_user_command('ExpiryStats', function()
  local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
  local by_year = {}
  local total = 0
  for _, line in ipairs(lines) do
    if extract_card(line) then
      local _, year = extract_expiry(line)
      if year then
        by_year[year] = (by_year[year] or 0) + 1
        total = total + 1
      end
    end
  end
  local years = {}
  for y in pairs(by_year) do table.insert(years, y) end
  table.sort(years)
  local msg = 'Expiry distribution (' .. total .. ' cards):\n'
  local current_year = tonumber(os.date('%Y'))
  for _, y in ipairs(years) do
    local tag = y < current_year and ' [EXPIRED]' or ''
    msg = msg .. y .. ': ' .. by_year[y] .. tag .. '\n'
  end
  vim.notify(msg, vim.log.levels.INFO)
end, { desc = 'CSV: show card count grouped by expiry year' })

-- Show duplicate card numbers and how many times each appears
vim.api.nvim_create_user_command('FindDuplicates', function()
  local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
  local count = {}
  for _, line in ipairs(lines) do
    local card = extract_card(line)
    if card then count[card] = (count[card] or 0) + 1 end
  end
  local dups = {}
  for card, n in pairs(count) do
    if n > 1 then table.insert(dups, { card = card, n = n }) end
  end
  if #dups == 0 then
    vim.notify('No duplicates found', vim.log.levels.INFO)
    return
  end
  table.sort(dups, function(a, b) return a.n > b.n end)
  local msg = #dups .. ' duplicate card(s):\n'
  for _, d in ipairs(dups) do
    msg = msg .. d.card .. '  x' .. d.n .. '\n'
  end
  vim.notify(msg, vim.log.levels.WARN)
end, { desc = 'CSV: list card numbers that appear more than once' })

-- CVV digit-length distribution (useful to check if ParseCVV is needed)
vim.api.nvim_create_user_command('CVVStats', function()
  local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
  local dist = { [1]=0, [2]=0, [3]=0, other=0 }
  local total = 0
  for _, line in ipairs(lines) do
    if extract_card(line) then
      local cvv = line:match('|20%d%d|(%d+)|')
      if cvv then
        total = total + 1
        local len = #cvv
        if len <= 3 then dist[len] = dist[len] + 1
        else dist.other = dist.other + 1
        end
      end
    end
  end
  local msg = 'CVV length distribution (' .. total .. ' cards):\n'
  msg = msg .. '1 digit : ' .. dist[1] .. '\n'
  msg = msg .. '2 digits: ' .. dist[2] .. '\n'
  msg = msg .. '3 digits: ' .. dist[3] .. '\n'
  if dist.other > 0 then msg = msg .. 'other   : ' .. dist.other .. '\n' end
  vim.notify(msg, vim.log.levels.INFO)
end, { desc = 'CSV: show CVV length distribution' })

-- Full data quality report: invalid months, years, missing fields, duplicates
vim.api.nvim_create_user_command('DataQualityReport', function()
  local current_year = tonumber(os.date('%Y'))
  local current_month = tonumber(os.date('%m'))
  local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
  local total, invalid_month, invalid_year, no_name, expired, dups_count = 0,0,0,0,0,0
  local seen = {}
  for _, line in ipairs(lines) do
    local card = extract_card(line)
    if card then
      total = total + 1
      if seen[card] then dups_count = dups_count + 1 else seen[card] = true end
      local month, year = extract_expiry(line)
      if not month or month < 1 or month > 12 then invalid_month = invalid_month + 1 end
      if not year or year < 2000 then invalid_year = invalid_year + 1 end
      if not line:match('|[A-Za-z]') then no_name = no_name + 1 end
      if year and month then
        if year < current_year or (year == current_year and month < current_month) then
          expired = expired + 1
        end
      end
    end
  end
  local ok = total - invalid_month - invalid_year - no_name - dups_count
  local msg = '=== Data Quality Report ===\n'
  msg = msg .. 'Total cards  : ' .. total .. '\n'
  msg = msg .. 'Valid (est.) : ' .. math.max(ok, 0) .. '\n'
  msg = msg .. 'Expired      : ' .. expired .. '\n'
  msg = msg .. 'Duplicates   : ' .. dups_count .. '\n'
  msg = msg .. 'Invalid month: ' .. invalid_month .. '\n'
  msg = msg .. 'Invalid year : ' .. invalid_year .. '\n'
  msg = msg .. 'Missing name : ' .. no_name .. '\n'
  vim.notify(msg, vim.log.levels.INFO)
end, { desc = 'CSV: full data quality report' })

-- Remove lines that don't match expected CSV structure (14+ card, month, year, cvv, name)
vim.api.nvim_create_user_command('RemoveInvalidLines', function()
  local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
  local result = {}
  for _, line in ipairs(lines) do
    local card = extract_card(line)
    if not card then
      table.insert(result, line) -- keep header
    else
      local month, year = extract_expiry(line)
      local cvv = line:match('|%d%d%d%d|(%d%d?%d?)|')
      local has_name = line:match('|[^|]+$') ~= nil
      if month and year and cvv and has_name
        and month >= 1 and month <= 12
        and year >= 2000 then
        table.insert(result, line)
      end
    end
  end
  local removed = #lines - #result
  vim.api.nvim_buf_set_lines(0, 0, -1, false, result)
  vim.notify('RemoveInvalidLines: ' .. removed .. ' invalid lines removed')
end, { desc = 'CSV: remove lines with invalid card structure' })

vim.api.nvim_create_user_command('FindCard', function(opts)
  -- cada bloco de *'s vira \d+
  local bin  = (opts.fargs[1] or ''):gsub('%*+', [[\d+]])
  local mm   = opts.fargs[2] or ''
  local yyyy = opts.fargs[3] or ''

  local pattern = string.format([[\v%s,%s,%s]], bin, mm, yyyy)

  -- joga no registro de busca pra n/N e hlsearch funcionarem
  vim.fn.setreg('/', pattern)
  vim.opt.hlsearch = true

  local found = vim.fn.search(pattern, 'w') -- 'w' = wrap around
  if found == 0 then
    vim.notify('Sem match para: ' .. pattern, vim.log.levels.WARN)
  end
end, { nargs = '+' })
