From: pavel@denx.de (Pavel Machek)
Date: Mon, 13 May 2019 21:03:22 +0200
Subject: [cip-dev] [PATCH 4.4.y 04/52] ARM: shmobile: r8a77470: Add
 clock index macros for DT sources
In-Reply-To: <1557761837-24993-5-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1557761837-24993-1-git-send-email-fabrizio.castro@bp.renesas.com>
	<1557761837-24993-5-git-send-email-fabrizio.castro@bp.renesas.com>
Message-ID: <20190513190322.GB27497@amd>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

On Mon 2019-05-13 16:36:29, Fabrizio Castro wrote:
> Add macros usable by device tree sources to reference the r8a77470
> clocks by index.

Is this commit in the mainline? I could not find it in recent mainline
nor in -next kernel.

> diff --git a/include/dt-bindings/clock/r8a77470-clock.h b/include/dt-bindings/clock/r8a77470-clock.h
> new file mode 100644
> index 0000000..2f20bcc
> --- /dev/null
> +++ b/include/dt-bindings/clock/r8a77470-clock.h
> @@ -0,0 +1,140 @@
> +/*
> + * Copyright (C) 2019 Renesas Electronics Corporation
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + */

World is moving to SPDX. (But you want to fix it in the mainline, not
here, so...)

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
URL: <http://lists.cip-project.org/pipermail/cip-dev/attachments/20190513/95c763c1/attachment.sig>
