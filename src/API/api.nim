import ../struct/client, httpClient, asyncdispatch

proc baseURL(path: string): string =
    return "https://api.revolt.chat/" & path

proc getfromAPI*(self: RevoltClient, path: string): Future[void] {.async.} =
    let content = await self.httpClient.getContent(baseURL(path))
    echo content
