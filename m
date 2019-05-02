From: pavel@denx.de (Pavel Machek)
Date: Thu, 2 May 2019 23:34:16 +0200
Subject: [cip-dev] [PATCH 4.19.y 29/29] arm64: defconfig: Enable R-Car
 thermal driver
In-Reply-To: <1556706143-11898-30-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1556706143-11898-1-git-send-email-fabrizio.castro@bp.renesas.com>
	<1556706143-11898-30-git-send-email-fabrizio.castro@bp.renesas.com>
Message-ID: <20190502213416.GE19728@amd>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hi!

> commit 4aac2bf0760d359af44e423dc01e10880d9d18b0 upstream.
> 
> Enable the R-Car thermal driver as a built-in.
> This seems safer than enabling as a module from the point of view of
> protecting equipment from overheating.

No objections here, but...

...make sure your hardware can protect itself when kernel fails for
whatever reason. Yes, crashes from time to time, and then thermal
support will fail, too.

Thanks,
									Pavel
									
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 181 bytes
Desc: Digital signature
URL: <http://lists.cip-project.org/pipermail/cip-dev/attachments/20190502/7088e5fe/attachment.sig>
