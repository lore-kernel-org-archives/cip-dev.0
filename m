Return-Path: <uli@fpond.eu>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD03CD2ED0F
	for <webhook@archiver.kernel.org>; Tue, 20 Jan 2026 03:36:49 +0000 (UTC)
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [81.169.146.163])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.809.1768880205496598567
 for <cip-dev@lists.cip-project.org>;
 Mon, 19 Jan 2026 19:36:46 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@fpond.eu header.s=strato-dkim-0002 header.b=fbCQUgaa;
 dkim=pass header.i=@fpond.eu header.s=strato-dkim-0003 header.b=NKHKxceQ;
 spf=none, err=permanent DNS error (domain: fpond.eu, ip: 81.169.146.163, mailfrom: uli@fpond.eu)
ARC-Seal: i=1; a=rsa-sha256; t=1768880203; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=g2XR78IaYvPNchws0swdzlFtsy3EP/s7Vvxtf4itIhS0JTlSSUmg1VGV1KMKMF68NL
    WRV9faV20Qa6yX9FlsPqdlwicx2vT/WUproggIRYXK5QQOMymvzy0ydOvTHdTZqpmdTc
    EZwE0gSXEDdFTLJiqTIiOUZOYiIB4dIVrTYH4rx2o/lf69eIp9JlEeX7uhzcATusY0Rk
    fjxMVzsxECUg4/hy8q55cZgJVlYGP+HP7oeFUWn/N8DBnDpzKXuG413aULnJempMkmwA
    /qclVN/Hh97SGcfD03OtpZKpUsMqyD7OC8BEeH4f2KObif2DXM0yn2Msg8xbheKkoX+8
    t+hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1768880203;
    s=strato-dkim-0002; d=strato.com;
    h=Subject:References:In-Reply-To:Message-ID:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=m/xYUH6HXmW1z5ElHRDMdOuTBSIYvymazQVoAh8JOMk=;
    b=S0YYRtWABMU/dxpJUi6IvzckdwxENF+n68012QcY0xEDY45lXc39Q2AWnBLY9q4WzL
    VD1+2u0oLpKDSOKwm5A3l9b16OR3QDgIJ/9ZdVuA+82K1wyGCVtzbJA4+avGQ+h6plOa
    DWeRdNJ3Fth0XClrmk19ZsNl06IPsDWnu/1G4wpqgrDDQE5x2Do9ckLhr3UGdNigOt/Z
    oG0dhLP1oQmNG7bofD2VioesYIGEn8M7A9VwTkVfg94FcAKlZAgd8G5sIRPCP+30yzmC
    FY2RZTPnUHcnFGOrrzrN1GubBifDZnr6K4BPcSEKbD5GGlf02cf1n9jRjU0p5MqLwabP
    kA/Q==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1768880203;
    s=strato-dkim-0002; d=fpond.eu;
    h=Subject:References:In-Reply-To:Message-ID:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=m/xYUH6HXmW1z5ElHRDMdOuTBSIYvymazQVoAh8JOMk=;
    b=fbCQUgaaVkNtyzzpiTgWVZ++jvBtC66HbZx4eH6UagneiwaM8FrPNCH2aHjGJXdwQG
    3cwFZGt6Ac7YxQMSqdi1POTNY62bsSIqyHffqsDZ/EP1mkqoddBT23TBGNEyukaUK8vL
    MX8VFqDllmGPtWqSfUi//t86wyE7XnUKSgbrYPsdj0JS/4o4y2RgfTX+gy5V0kNH7vxV
    wpYidVBbWVljyHHCV677T6lbSd6JaN+oJHr2/ud+xJffrA/UEsli+q9WMgEipJri/mpG
    kgsn9a66BUAoAML4yTjgPRHtpxuKDAwDul8CJsspbX+CIKHeSI9DYnyy8APkVgkhXKZL
    5XVQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1768880203;
    s=strato-dkim-0003; d=fpond.eu;
    h=Subject:References:In-Reply-To:Message-ID:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=m/xYUH6HXmW1z5ElHRDMdOuTBSIYvymazQVoAh8JOMk=;
    b=NKHKxceQdRYRjofEXDpHmBG2nwCFe5nE26txkP6mEc0oaWFfikBNg545dHYvxK7azx
    I/eccvJ6TcvPWhGYk+Aw==
X-RZG-AUTH: ":OWANVUa4dPFUgKR/3dpvnYP0Np73amq+g13rqGzvtHhj3fsqaRxGvsqHiA=="
Received: from open-xchange-core-mw-gw-31.open-xchange-core-mw-hazelcast-headless.open-xchange.svc.cluster.local
    by smtp-ox.front (RZmta 54.1.0 AUTH)
    with ESMTPSA id zfda1720K3agGIx
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256 bits))
	(Client did not present a certificate);
    Tue, 20 Jan 2026 04:36:42 +0100 (CET)
Date: Tue, 20 Jan 2026 04:36:42 +0100 (CET)
From: Ulrich Hecht <uli@fpond.eu>
To: claudiu beznea <claudiu.beznea@tuxon.dev>,
	"pavel@nabladev.com" <pavel@nabladev.com>,
	"nobuhiro.iwamatsu.x90@mail.toshiba" <nobuhiro.iwamatsu.x90@mail.toshiba>
Cc: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
Message-ID: <824491551.118353.1768880202353@webmail.strato.de>
In-Reply-To: <20260115083604.1064260-3-claudiu.beznea.uj@bp.renesas.com>
References: <20260115083604.1064260-1-claudiu.beznea.uj@bp.renesas.com>
 <20260115083604.1064260-3-claudiu.beznea.uj@bp.renesas.com>
Subject: Re: [cip-dev] [PATCH 6.12.y-cip v3 02/19] PM: domains: Add helper
 to check for PM domain detach on unbind cleanup
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Normal
X-Mailer: Open-Xchange Mailer v8.42.74
X-Originating-Port: 41248
X-Originating-Client: open-xchange-appsuite
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 20 Jan 2026 03:36:49 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21678


> On 01/15/2026 9:35 AM CET claudiu beznea <claudiu.beznea@tuxon.dev> wrote:
> 
>  
> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> 
> Add helper to check if PM domain detach is allowed in
> device_unbind_cleanup(). This is necessary to avoid issues when unbinding
> as decribed in commit f99508074e78 ("PM: domains: Detach on

described

> device_unbind_cleanup()").
> 
> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> ---
>  drivers/base/power/common.c | 20 ++++++++++++++++++++
>  include/linux/pm_domain.h   |  5 +++++
>  2 files changed, 25 insertions(+)
> 
> diff --git a/drivers/base/power/common.c b/drivers/base/power/common.c
> index 0581fa25460b..abbbcf85a5b2 100644
> --- a/drivers/base/power/common.c
> +++ b/drivers/base/power/common.c
> @@ -433,3 +433,23 @@ int dev_pm_domain_set_performance_state(struct device *dev, unsigned int state)
>  	return 0;
>  }
>  EXPORT_SYMBOL_GPL(dev_pm_domain_set_performance_state);
> +
> +/**
> + * dev_pm_domain_allow_detach_on_unbind_cleanup - Check if PM domain
> + * detach during the unbind cleanup driver remove phase is permitted.
> + *
> + * Returns true if allowed, false otherwise
> + */
> +bool dev_pm_domain_allow_detach_on_unbind_cleanup(void)
> +{
> +	static const char * const pm_detach_allow_list[] = {
> +		"renesas,r9a07g043", /* Renesas RZ/{G2UL, Five} */
> +		"renesas,r9a07g044", /* Renesas RZ/G2{L, LC} */
> +		"renesas,r9a07g054", /* Renesas RZ/V2L */
> +		"renesas,r9a08g045", /* Renesas RZ/G3S */
> +		NULL
> +	};
> +
> +	return of_machine_compatible_match(pm_detach_allow_list);
> +}
> +EXPORT_SYMBOL_GPL(dev_pm_domain_allow_detach_on_unbind_cleanup);
> diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
> index be1e09f297dc..4a698f926185 100644
> --- a/include/linux/pm_domain.h
> +++ b/include/linux/pm_domain.h
> @@ -503,6 +503,7 @@ void dev_pm_domain_detach_list(struct dev_pm_domain_list *list);
>  int dev_pm_domain_start(struct device *dev);
>  void dev_pm_domain_set(struct device *dev, struct dev_pm_domain *pd);
>  int dev_pm_domain_set_performance_state(struct device *dev, unsigned int state);
> +bool dev_pm_domain_allow_detach_on_unbind_cleanup(void);
>  #else
>  static inline int dev_pm_domain_attach(struct device *dev, u32 flags)
>  {
> @@ -545,6 +546,10 @@ static inline int dev_pm_domain_set_performance_state(struct device *dev,
>  {
>  	return 0;
>  }
> +static bool dev_pm_domain_allow_detach_on_unbind_cleanup(void)
> +{
> +	return false;
> +}
>  #endif
>  
>  #endif /* _LINUX_PM_DOMAIN_H */
> -- 
> 2.43.0

Reviewed-by: Ulrich Hecht <uli@fpond.eu>

CU
Uli

