From: hidehiro.kawai.ez@hitachi.com (=?utf-8?B?5rKz5ZCI6Iux5a6PIC8gS0FXQUnvvIxISURFSElSTw==?=)
Date: Fri, 28 Jul 2017 05:10:44 +0000
Subject: [cip-dev] Kernel feature support - core features and debugging
In-Reply-To: <1500652489.12197.162.camel@codethink.co.uk>
References: <1500652489.12197.162.camel@codethink.co.uk>
Message-ID: <04EAB7311EE43145B2D3536183D1A8445B9660D5@GSjpTKYDCembx31.service.hitachi.net>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hi Ben,

Thanks for the consideration and suggestion.

> From: Ben Hutchings
> Performance events (CONFIG_PERF_EVENTS) provide a significant attack
> surface and generally allow unprivileged users to crash the system.  If
> you do need them enabled in production - which I can understand - you
> might want to apply the Grsecurity/Debian/Android patch that disables
> use by unprivileged users.

Is it difficult to support for super long term?  I think it is up to
users to enable it or not.

> User namespaces (CONFIG_USER_NS) open up a huge attack surface to
> unprivileged users, which has resulted in a large number of privilege
> escalation vulnerabilities.  This is enabled in the plathome_obsvx1,
> siemens_iot2000 and siemens_server configs.  Do you need it?

I'm not sure how vulnerable it is, but I think we may want to adopt the
same approach with the CONFIG_PERF_EVENTS case.
https://github.com/copperhead/linux-hardened/commit/358b303ebdc0b4a74b66a41ddfd2a69322d5404a.patch

Best regards,

Hidehiro Kawai
Hitachi, Ltd. Research & Development Group
