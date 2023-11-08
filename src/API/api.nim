import ../struct/[client, user], httpClient, asyncdispatch, jsony, uri,
        strutils, sequtils

proc baseURL(path: string): string =
    return "https://api.revolt.chat/" & path


# API HANDLER
proc getfromAPI*(self: RevoltClient, path: seq[string]): Future[
        string] {.async.} =
    let mapped = map(toSeq(path), proc (x: string): string = encodeUrl(x))
    return await self.httpClient.getContent(baseURL(join(mapped, "/")))

proc getUserSelf*(self: RevoltClient): Future[User] {.async.} =
    let j = await self.getfromAPI(@["users", "@me"])

    return fromJson(j, User)

proc getUserID*(self: RevoltClient, id: string): Future[User] {.async.} =
    let j = await self.getfromAPI(@["users", id])

    return fromJson(j, User)

proc fetchUserProfile*(self: RevoltClient, id: string): Future[
        UserProfile] {.async.} =
    let j = await self.getfromAPI(@["users", id, "profile"])

    return fromJson(j, UserProfile)

proc fetchUserFlags*(self: RevoltClient, id: string): Future[
        UserFlags] {.async.} =
    let j = await self.getfromAPI(@["users", id, "flags"])

    return fromJson(j, UserFlags)
