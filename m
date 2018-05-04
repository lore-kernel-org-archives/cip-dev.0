From: ben.hutchings@codethink.co.uk (Ben Hutchings)
Date: Fri, 04 May 2018 17:12:18 +0100
Subject: [cip-dev] [PATCH 0/6] Fix R-Car I2C data byte sent twice issue
In-Reply-To: <1524130381-4346-1-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1524130381-4346-1-git-send-email-fabrizio.castro@bp.renesas.com>
Message-ID: <1525450338.6671.19.camel@codethink.co.uk>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

On Thu, 2018-04-19 at 10:32 +0100, Fabrizio Castro wrote:
> Hello Ben,
> 
> a few weeks ago Zoran Stojsavljevic reported a problem with the RTC
> on the iwg20d that turned out to be a problem with the I2C driver
> sporadically sending data twice. This series backports the commits
> from Wolfram that make up for the fix.
> 
> This series applies on top of v4.4.126-cip22.
[...]

These changes appear to be suitable for 4.4-stable too.  Please can you
send them to Greg and the stable list?

I can *also* apply them directly to the 4.4-cip branch rather than
waiting for them to get into a stable release, but I don't think we
should be keeping fixes to ourselves.

Ben.

-- 
Ben Hutchings
Software Developer, Codethink Ltd.
