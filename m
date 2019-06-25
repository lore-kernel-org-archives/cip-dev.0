From: pavel@ucw.cz (Pavel Machek)
Date: Tue, 25 Jun 2019 10:52:26 +0200
Subject: [cip-dev] [PATCH 4.4-cip] spi: pxa2xx: Fix build error because
 of missing header
In-Reply-To: <20190620123746.4boosxdwr2vapgu4@xylophone.i.decadent.org.uk>
References: <20190620123746.4boosxdwr2vapgu4@xylophone.i.decadent.org.uk>
Message-ID: <20190625085226.GA2928@amd>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

On Thu 2019-06-20 13:37:46, Ben Hutchings wrote:
> From: Mika Westerberg <mika.westerberg@linux.intel.com>
> 
> commit 089bd46d8bc1fe5a28351e82e4adcaa5a40121b5 upstream.
> 
> Kbuild test robot reports:
> 
>   drivers/spi/spi-pxa2xx.c: In function ?setup_cs?:
>   drivers/spi/spi-pxa2xx.c:1190:20: error: implicit declaration of function ?desc_to_gpio?
>   ...
> 
> Reason for this is the fact that those functions are declared in
> linux/gpio/consumer.h which is not included in the driver. Fix this by
> including it.

Thanks, applied.

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
URL: <http://lists.cip-project.org/pipermail/cip-dev/attachments/20190625/f1c95d57/attachment.sig>
