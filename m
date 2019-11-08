From: pavel@denx.de (Pavel Machek)
Date: Fri, 8 Nov 2019 11:38:17 +0100
Subject: [cip-dev] [PATCH 4.4.y-cip 74/83] mmc: tmio-mmc: fix bad
	pointer math
In-Reply-To: <1573115572-13513-75-git-send-email-biju.das@bp.renesas.com>
References: <1573115572-13513-1-git-send-email-biju.das@bp.renesas.com>
	<1573115572-13513-75-git-send-email-biju.das@bp.renesas.com>
Message-ID: <20191108103817.GP1017@amd>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hi!

> From: Chris Brandt <chris.brandt@renesas.com>
> 
> commit b5dd7985e8d3357ff9537c0be231190ab1a131fe upstream.
> 
> commit 9c284c41c0886f09e75c323a16278b6d353b0b4a upstream.
> 
> The existing code gives an incorrect pointer value.
> The buffer pointer 'buf' was of type unsigned short *, and 'count' was a
> number in bytes. A cast of buf should have been used.
> 
> However, instead of casting, just change the code to use u32
> pointers.

Yep, I see, nasty; silent data corruption. Could this be merged to the
patch that introduces the problem, or the original patch somehow
modified that it will not corrupt data ... for example during bisection?

> +++ b/drivers/mmc/host/tmio_mmc_core.c
> @@ -446,30 +446,29 @@ static void tmio_mmc_transfer_data(struct tmio_mmc_host *host,
>  	 * Transfer the data
>  	 */
>  	if (host->pdata->flags & TMIO_MMC_32BIT_DATA_PORT) {
> -		u8 data[4] = { };
> +		u32 data = 0;
> +		u32 *buf32 = (u32 *)buf;
>  
>  		if (is_read)
> -			sd_ctrl_read32_rep(host, CTL_SD_DATA_PORT, (u32 *)buf,
> +			sd_ctrl_read32_rep(host, CTL_SD_DATA_PORT, buf32,
>  					   count >> 2);
>  		else
> -			sd_ctrl_write32_rep(host, CTL_SD_DATA_PORT, (u32 *)buf,
> +			sd_ctrl_write32_rep(host, CTL_SD_DATA_PORT, buf32,
>  					    count >> 2);
>  
>  		/* if count was multiple of 4 */
>  		if (!(count & 0x3))
>  			return;
>  
> -		buf8 = (u8 *)(buf + (count >> 2));
> +		buf32 += count >> 2;
>  		count %= 4;

Can we do count &= 0x3, to keep style of if () above? Actually you can
do 

    count &= 0x3;
    if (!count) return;

Plus, there's code handling 16 bit case just below this; it is
different in style, and by using

    *buf8 = sd_ctrl_read16(host, CTL_SD_DATA_PORT) & 0xff;

instead of read16_rep(), it is buggy on big endian (as comment
says). Perhaps synchronizing to similar, non-buggy version would be
good?

Best regards,
								Pavel
-- 
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 181 bytes
Desc: Digital signature
URL: <http://lists.cip-project.org/pipermail/cip-dev/attachments/20191108/617ad473/attachment.sig>
