From: pavel@denx.de (Pavel Machek)
Date: Tue, 16 Jul 2019 23:03:50 +0200
Subject: [cip-dev] [PATCH 4.4.y-cip 03/10] rtc: pcf85363: set time
 accurately
In-Reply-To: <1563264921-42973-4-git-send-email-biju.das@bp.renesas.com>
References: <1563264921-42973-1-git-send-email-biju.das@bp.renesas.com>
	<1563264921-42973-4-git-send-email-biju.das@bp.renesas.com>
Message-ID: <20190716210350.GB14181@amd>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

On Tue 2019-07-16 09:15:14, Biju Das wrote:
> commit 188306ac9536ec47674ffa9dd330f69927679aeb upstream.
> 
> As per 8.2.6 Setting and reading the time in RTC mode, first stop the clok,
> then reset it before setting the date and time registers. Finally, start
> the clock.
> 
> This uses register address wrap around from 0x2f to 0x00 for
> efficiency.

How does wrap around work? AFAICT it is supposed to have ram at 0x40.

Does it really provide increased efficiency (given regmap layer in
between) and will such trick cause problems in future? If regmap is
not aware of register mirrors it might get confused and provide stale
values, for example...

Best regards,
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
URL: <http://lists.cip-project.org/pipermail/cip-dev/attachments/20190716/f24183ef/attachment.sig>
