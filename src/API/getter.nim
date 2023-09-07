import ../struct/[error, client, server, user], sequtils

proc getUser*(self: RevoltClient, userId: string): User =
    var users = filter(self.users, proc(x: User): bool = x.id == userId)
    if users.len < 1:
        raise UserNotFound(msg: "Cannot find that user")
    else:
        return users[0]

proc getServer*(self: RevoltClient, serverId: string): Server =
    var servers = filter(self.servers, proc(x: Server): bool = x.id == serverId)
    if servers.len < 1:
        raise ServerNotFound(msg: "Cannot find that server")
    else:
        return servers[0]
