public enum OAuthScopeError: Error {
    case unknownScopes(String)
}

public struct OAuthScope: OptionSet {
        public let rawValue: Int

        public init(rawValue: Int) {
            self.rawValue = rawValue
        }

        /// https://www.rfc-editor.org/rfc/rfc6749#section-3.3
        ///
        ///     scope       = scope-token *( SP scope-token )
        ///     scope-token = 1*( %x21 / %x23-5B / %x5D-7E )
        ///
        /// Note this implementation is more liberal than the spec, where `SP` will match single or multiple spaces.
        ///
        public init(_ str: String) throws {
            let components = str.split(separator: " ").map(String.init)
            let table = [
                "read": OAuthScope.read.rawValue,
                "read:accounts": OAuthScope.read_accounts.rawValue,
                "read:blocks": OAuthScope.read_blocks.rawValue,
                "read:bookmarks": OAuthScope.read_bookmarks.rawValue,
                "read:favourites": OAuthScope.read_favourites.rawValue,
                "read:filters": OAuthScope.read_filters.rawValue,
                "read:follows": OAuthScope.read_follows.rawValue,
                "read:lists": OAuthScope.read_lists.rawValue,
                "read:mutes": OAuthScope.read_mutes.rawValue,
                "read:notifications": OAuthScope.read_notifications.rawValue,
                "read:search": OAuthScope.read_search.rawValue,
                "read:statuses": OAuthScope.read_statuses.rawValue,
                "write": OAuthScope.write.rawValue,
                "write:accounts": OAuthScope.write_accounts.rawValue,
                "write:blocks": OAuthScope.write_blocks.rawValue,
                "write:bookmarks": OAuthScope.write_bookmarks.rawValue,
                "write:conversations": OAuthScope.write_conversations.rawValue,
                "write:favourites": OAuthScope.write_favourites.rawValue,
                "write:filters": OAuthScope.write_filters.rawValue,
                "write:follows": OAuthScope.write_follows.rawValue,
                "write:lists": OAuthScope.write_lists.rawValue,
                "write:media": OAuthScope.write_media.rawValue,
                "write:mutes": OAuthScope.write_mutes.rawValue,
                "write:notifications": OAuthScope.write_notifications.rawValue,
                "write:reports": OAuthScope.write_reports.rawValue,
                "write:statuses": OAuthScope.write_statuses.rawValue,
                "follow": OAuthScope.follow.rawValue,
                "push": OAuthScope.push.rawValue,
                "admin:read": OAuthScope.admin_read.rawValue,
                "admin:read:accounts": OAuthScope.admin_read_accounts.rawValue,
                "admin:read:reports": OAuthScope.admin_read_reports.rawValue,
                "admin:read:domain_allows": OAuthScope.admin_read_domain_allows.rawValue,
                "admin:read:domain_blocks": OAuthScope.admin_read_domain_blocks.rawValue,
                "admin:read:ip_blocks": OAuthScope.admin_read_ip_blocks.rawValue,
                "admin:read:email_domain_blocks": OAuthScope.admin_read_email_domain_blocks.rawValue,
                "admin:read:canonical_email_blocks": OAuthScope.admin_read_canonical_email_blocks.rawValue,
                "admin:write": OAuthScope.admin_write.rawValue,
                "admin:write:accounts": OAuthScope.admin_write_accounts.rawValue,
                "admin:write:reports": OAuthScope.admin_write_reports.rawValue,
                "admin:write:domain_allows": OAuthScope.admin_write_domain_allows.rawValue,
                "admin:write:domain_blocks": OAuthScope.admin_write_domain_blocks.rawValue,
                "admin:write:ip_blocks": OAuthScope.admin_write_ip_blocks.rawValue,
                "admin:write:email_domain_blocks": OAuthScope.admin_write_email_domain_blocks.rawValue,
                "admin:write:canonical_email_blocks": OAuthScope.admin_write_canonical_email_blocks.rawValue,
            ]
            let missingComponents = components.filter { table[$0] == nil }
            if !missingComponents.isEmpty {
                throw OAuthScopeError.unknownScopes(missingComponents.joined(separator: ","))
            }

            rawValue = components.map { table[$0]! }.reduce(0, |)
        }

        public static let read               = OAuthScope(rawValue: 0x7ff)
        public static let read_accounts      = OAuthScope(rawValue: 1 << 0)
        public static let read_blocks        = OAuthScope(rawValue: 1 << 1)
        public static let read_bookmarks     = OAuthScope(rawValue: 1 << 2)
        public static let read_favourites    = OAuthScope(rawValue: 1 << 3)
        public static let read_filters       = OAuthScope(rawValue: 1 << 4)
        public static let read_follows       = OAuthScope(rawValue: 1 << 5)
        public static let read_lists         = OAuthScope(rawValue: 1 << 6)
        public static let read_mutes         = OAuthScope(rawValue: 1 << 7)
        public static let read_notifications = OAuthScope(rawValue: 1 << 8)
        public static let read_search        = OAuthScope(rawValue: 1 << 9)
        public static let read_statuses      = OAuthScope(rawValue: 1 << 10)

        public static let write               = OAuthScope(rawValue: 0x1fff << 16)
        public static let write_accounts      = OAuthScope(rawValue: 1 << 16)
        public static let write_blocks        = OAuthScope(rawValue: 1 << 17)
        public static let write_bookmarks     = OAuthScope(rawValue: 1 << 18)
        public static let write_conversations = OAuthScope(rawValue: 1 << 19)
        public static let write_favourites    = OAuthScope(rawValue: 1 << 20)
        public static let write_filters       = OAuthScope(rawValue: 1 << 21)
        public static let write_follows       = OAuthScope(rawValue: 1 << 22)
        public static let write_lists         = OAuthScope(rawValue: 1 << 23)
        public static let write_media         = OAuthScope(rawValue: 1 << 24)
        public static let write_mutes         = OAuthScope(rawValue: 1 << 25)
        public static let write_notifications = OAuthScope(rawValue: 1 << 26)
        public static let write_reports       = OAuthScope(rawValue: 1 << 27)
        public static let write_statuses      = OAuthScope(rawValue: 1 << 28)

        /// `follow` is deprecated and now represented by granular scopes.
        public static let follow: OAuthScope  = [.read_blocks,.write_blocks,.read_follows,.write_follows,.read_mutes,.write_mutes]

        public static let push                = OAuthScope(rawValue: 1 << 31)

        public static let admin_read                        = OAuthScope(rawValue: 0x7f << 32)
        public static let admin_read_accounts               = OAuthScope(rawValue: 1 << 32)
        public static let admin_read_reports                = OAuthScope(rawValue: 1 << 33)
        public static let admin_read_domain_allows          = OAuthScope(rawValue: 1 << 34)
        public static let admin_read_domain_blocks          = OAuthScope(rawValue: 1 << 35)
        public static let admin_read_ip_blocks              = OAuthScope(rawValue: 1 << 36)
        public static let admin_read_email_domain_blocks    = OAuthScope(rawValue: 1 << 37)
        public static let admin_read_canonical_email_blocks = OAuthScope(rawValue: 1 << 38)

        public static let admin_write                        = OAuthScope(rawValue: 0x7f << 48)
        public static let admin_write_accounts               = OAuthScope(rawValue: 1 << 48)
        public static let admin_write_reports                = OAuthScope(rawValue: 1 << 49)
        public static let admin_write_domain_allows          = OAuthScope(rawValue: 1 << 50)
        public static let admin_write_domain_blocks          = OAuthScope(rawValue: 1 << 51)
        public static let admin_write_ip_blocks              = OAuthScope(rawValue: 1 << 52)
        public static let admin_write_email_domain_blocks    = OAuthScope(rawValue: 1 << 53)
        public static let admin_write_canonical_email_blocks = OAuthScope(rawValue: 1 << 54)


        ///
        public var asString: String {
            var result = [String]()

            if rawValue & OAuthScope.read.rawValue == OAuthScope.read.rawValue {
                result.append("read")
            } else if rawValue & OAuthScope.read.rawValue != 0 {
                result += [
                    OAuthScope.read_accounts.rawValue: "read:accounts",
                    OAuthScope.read_blocks.rawValue: "read:blocks",
                    OAuthScope.read_bookmarks.rawValue: "read:bookmarks",
                    OAuthScope.read_favourites.rawValue: "read:favourites",
                    OAuthScope.read_filters.rawValue: "read:filters",
                    OAuthScope.read_follows.rawValue: "read:follows",
                    OAuthScope.read_lists.rawValue: "read:lists",
                    OAuthScope.read_mutes.rawValue: "read:mutes",
                    OAuthScope.read_notifications.rawValue: "read:notifications",
                    OAuthScope.read_search.rawValue: "read:search",
                    OAuthScope.read_statuses.rawValue: "read:statuses",
                ].filter { self.rawValue & $0.key != 0 }.values
            }

            if rawValue & OAuthScope.write.rawValue == OAuthScope.write.rawValue {
                result.append("write")
            } else if rawValue & OAuthScope.write.rawValue != 0 {
                result += [
                    OAuthScope.write_accounts.rawValue: "write:accounts",
                    OAuthScope.write_blocks.rawValue: "write:blocks",
                    OAuthScope.write_bookmarks.rawValue: "write:bookmarks",
                    OAuthScope.write_conversations.rawValue: "write:conversations",
                    OAuthScope.write_favourites.rawValue: "write:favourites",
                    OAuthScope.write_filters.rawValue: "write:filters",
                    OAuthScope.write_follows.rawValue: "write:follows",
                    OAuthScope.write_lists.rawValue: "write:lists",
                    OAuthScope.write_media.rawValue: "write:media",
                    OAuthScope.write_mutes.rawValue: "write:mutes",
                    OAuthScope.write_notifications.rawValue: "write:notifications",
                    OAuthScope.write_reports.rawValue: "write:reports",
                    OAuthScope.write_statuses.rawValue: "write:statuses",
                ].filter { self.rawValue & $0.key != 0 }.values
            }

            // .follow is deprecated and not composed for interchange string. Postel's law.

            if rawValue & OAuthScope.push.rawValue == OAuthScope.push.rawValue {
                result.append("push")
            }

            if rawValue & OAuthScope.admin_read.rawValue == OAuthScope.admin_read.rawValue {
                result.append("admin:read")
            } else if rawValue & OAuthScope.admin_read.rawValue != 0 {
                result += [
                    OAuthScope.admin_read_accounts.rawValue: "admin:read:accounts",
                    OAuthScope.admin_read_reports.rawValue: "admin:read:reports",
                    OAuthScope.admin_read_domain_allows.rawValue: "admin:read:domain_allows",
                    OAuthScope.admin_read_domain_blocks.rawValue: "admin:read:domain_blocks",
                    OAuthScope.admin_read_ip_blocks.rawValue: "admin:read:ip_blocks",
                    OAuthScope.admin_read_email_domain_blocks.rawValue: "admin:read:email_domain_blocks",
                    OAuthScope.admin_read_canonical_email_blocks.rawValue: "admin:read:canonical_email_blocks",
                ].filter { self.rawValue & $0.key != 0 }.values
            }

            if rawValue & OAuthScope.admin_write.rawValue == OAuthScope.admin_write.rawValue {
                result.append("admin:write")
            } else if rawValue & OAuthScope.admin_write.rawValue != 0 {
                result += [
                    OAuthScope.admin_write_accounts.rawValue: "admin:write:accounts",
                    OAuthScope.admin_write_reports.rawValue: "admin:write:reports",
                    OAuthScope.admin_write_domain_allows.rawValue: "admin:write:domain_allows",
                    OAuthScope.admin_write_domain_blocks.rawValue: "admin:write:domain_blocks",
                    OAuthScope.admin_write_ip_blocks.rawValue: "admin:write:ip_blocks",
                    OAuthScope.admin_write_email_domain_blocks.rawValue: "admin:write:email_domain_blocks",
                    OAuthScope.admin_write_canonical_email_blocks.rawValue: "admin:write:canonical_email_blocks",
                ].filter { self.rawValue & $0.key != 0 }.values
            }

            return result.sorted().joined(separator: " ")
        }

        public func checkMissingSupersetScopes(of supersetScope: OAuthScope) -> OAuthScope? {
            let rawValue = self.rawValue & ~supersetScope.rawValue
            guard rawValue != 0 else { return nil }
            return OAuthScope(rawValue: rawValue)
        }
}
