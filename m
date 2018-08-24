From: ben.hutchings@codethink.co.uk (Ben Hutchings)
Date: Fri, 24 Aug 2018 20:07:50 +0100
Subject: [cip-dev] [PATCH 00/42] Add watchdog support to iwg20m and
	iwg22m
In-Reply-To: <1532626980-17190-1-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1532626980-17190-1-git-send-email-fabrizio.castro@bp.renesas.com>
Message-ID: <1535137670.2902.47.camel@codethink.co.uk>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

On Thu, 2018-07-26 at 18:42 +0100, Fabrizio Castro wrote:
> Hello Ben,
> 
> this series backports watchdog support for iwg20m and iwg22m.
> 
> There is a dependency with series:
> https://lists.cip-project.org/pipermail/cip-dev/2018-July/001415.html
> 
> This work is based on top of linux-4.4.y-cip, commit
> 4d769b2b8749e89dfc7ea179a44f652dcfbedb37 ("PM / OPP: Move error
> message to debug level").

Thanks.  I've applied these, with the updated (v2) commit messages
for?"soc: renesas: Add R-Car RST driver" and "watchdog: renesas-wdt:
add driver" and the fix I mentioned for "watchdog: renesas_wdt: Add
restart handler".

Ben.

-- 
Ben Hutchings, Software Developer                ?        Codethink Ltd
https://www.codethink.co.uk/                 Dale House, 35 Dale Street
                                     Manchester, M1 2HF, United Kingdom
