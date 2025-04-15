local https = require("ssl.https")
local json = require("dkjson")

-- Configurações
local SYS_AID_API_URL = ""
local SYS_AID_API_KEY = "SUA_CHAVE_API"
local TELEGRAM_BOT_TOKEN = "7446410631:AAFBebwbOrea5k8WzqAOoufRpR0ResxW0Nw"
local TELEGRAM_CHAT_ID = "974055212"
local last_checked_id = nil

-- Função para buscar chamados no SysAid de um usuário específico
local function get_new_tickets(user_id)
    -- Adiciona o filtro na URL para buscar os chamados do usuário específico
    local url = SYS_AID_API_URL .. "?user_id=" .. user_id
    local headers = {
        ["Authorization"] = "Bearer " .. SYS_AID_API_KEY,
        ["Content-Type"] = "application/json"
    }
    local response_body = {}
    local res, code = https.request{
        url = url,
        method = "GET",
        headers = headers,
        sink = ltn12.sink.table(response_body)
    }
    
    if code == 200 then
        local data = json.decode(table.concat(response_body))
        if data and data.requests then
            return data.requests
        end
    end
    return {}
end

-- Função para enviar notificação no Telegram
local function send_telegram_message(message)
    local url = "https://api.telegram.org/bot" .. TELEGRAM_BOT_TOKEN .. "7446410631:AAFBebwbOrea5k8WzqAOoufRpR0ResxW0Nw" .. TELEGRAM_CHAT_ID .. "974055212" .. message
    https.request(url)
end

local paulo_henrique = "12345"

-- Loop para monitorar chamados
while true do
    local tickets = get_new_tickets(paulo_henrique)  -- Passando o ID do usuário específico
    for _, ticket in ipairs(tickets) do
        if not last_checked_id or ticket.id > last_checked_id then
            send_telegram_message("Novo chamado: " .. ticket.title .. "\nDescrição: " .. ticket.description)
            last_checked_id = ticket.id
        end
    end
    os.execute("sleep 60") -- Verifica a cada 60 segundos
end