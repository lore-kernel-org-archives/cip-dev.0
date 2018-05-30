From: ben.hutchings@codethink.co.uk (Ben Hutchings)
Date: Wed, 30 May 2018 17:41:51 +0100
Subject: [cip-dev] [PATCH 0/7] Add HDMI support to iwg20d
In-Reply-To: <1526383197-5913-1-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1526383197-5913-1-git-send-email-fabrizio.castro@bp.renesas.com>
Message-ID: <1527698511.2289.20.camel@codethink.co.uk>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

On Tue, 2018-05-15 at 12:19 +0100, Fabrizio Castro wrote:
> Dear Ben,
> 
> this series adds HDMI video output to iWave's iwg20d board.
> 
> I had to take out interrupt (hotplug) support from the hdmi DT node as
> it looks like commit 9183e45db7774716d056319c237a4185baba19c7 introduced
> "connector" data field with struct adv7511, but drm_connector_init was
> left behind, and as such connector.dev is NULL, and that causes issues
> to function adv7511_hpd_work, preventing HDMI hotplug from working
> properly.
> 
> While investigating HDMI hotplugging, I have found out that when using
> a GPIO purely as an interrupt source the corresponding GPIO module
> clock is not enabled, therefore this series backports the fix for this.
> I yet have to check if this fix is any good to 4.4 LTS, I'll send it to
> stable at vger.kernel.org in case it works for 4.4 LTS too.
> 
> This series applies on top of tag v4.4.126-cip22.
[...]

I've applied patches 1-5 only, as you requested.  Thanks.

Ben.

-- 
Ben Hutchings, Software Developer                ?        Codethink Ltd
https://www.codethink.co.uk/                 Dale House, 35 Dale Street
                                     Manchester, M1 2HF, United Kingdom
We respect your privacy.?? See https://www.codethink.co.uk/privacy.html
