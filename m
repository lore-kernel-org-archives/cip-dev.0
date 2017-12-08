From: ben.hutchings@codethink.co.uk (Ben Hutchings)
Date: Fri, 08 Dec 2017 16:22:48 +0000
Subject: [cip-dev] [PATCH] wireless: change cfg80211 regulatory domain
 info as debug messages
In-Reply-To: <20171127154644.4503-1-mosipov@ilbers.de>
References: <20171127154644.4503-1-mosipov@ilbers.de>
Message-ID: <1512750168.18523.252.camel@codethink.co.uk>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

On Mon, 2017-11-27 at 16:46 +0100, Maxim Yu. Osipov wrote:
> commit 94c4fd641e1bc438092f0214bb5ec77ea73b13cf upstream.
> 
> cfg80211 module prints a lot of messages like below. Actually printing
> once is acceptable but sometimes it will print again and again, it looks
> very annoying. It is better to change these detail messages to debugging
> only.
[...]

Applied (with the correct author information).

Ben.

-- 
Ben Hutchings
Software Developer, Codethink Ltd.
