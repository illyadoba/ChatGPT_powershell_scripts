$Cred = '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'
$Head = @{
    Authorization = 'Bearer ' + $Cred
    'Content-Type' = 'application/json'
}
$Url = "https://api.openai.com/v1/chat/completions"
$enc = [System.Text.Encoding]::UTF8
$text = Get-Clipboard
$filePath = "C:\Users\illya\ChatGPT_Response.json"
$regexPattern = '"content": "(.*?)"'
$Body = @{
    "model" = "gpt-3.5-turbo"
    "messages" = @(
        @{
            "role"="system"
            "content" = "You will be provided with statements, and your task is to convert them to standard Czech."
        },
        @{
            "role"="user"
            "content" = "$text"
        }
        )
} | ConvertTo-Json 
Invoke-RestMethod -Method 'Post' -Uri $url -Body $enc.GetBytes($body) -OutFile $filePath -Headers $Head 

$fileContent = Get-Content -Path $filePath -Raw -Encoding UTF8

$match = [regex]::Matches($fileContent, $regexPattern)

Set-Clipboard -Value $($match.Groups[1].Value)