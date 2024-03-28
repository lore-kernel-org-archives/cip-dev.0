Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 400F3C54E67
	for <webhook@archiver.kernel.org>; Thu, 28 Mar 2024 11:44:38 +0000 (UTC)
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
 by mx.groups.io with SMTP id smtpd.web11.13668.1711626267483932916
 for <cip-dev@lists.cip-project.org>;
 Thu, 28 Mar 2024 04:44:28 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=GJSBBMs3;
 spf=pass (domain: tuxon.dev, ip: 209.85.167.42, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-515a97846b5so817934e87.2
        for <cip-dev@lists.cip-project.org>; Thu, 28 Mar 2024 04:44:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1711626265; x=1712231065; darn=lists.cip-project.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3y+KXWEfWfpEojVj1X6/3zY4ZRTAAz5xP7hkSyIkL50=;
        b=GJSBBMs3cFhkx9C/KGiBWPjzDpbA3A3QDWSzSJRhDQfrZvdsoK15Wlo7PgXy9m9inn
         MexvADtus3FViZpvj6nlgQdR1vkhxfgcLPDDv/eavxYCusm1nzjmmS04LLETK8ltAvSE
         ddfsnuzzAx9bkcXnYstw5dTPG6drbMVSTAxQIlqmRI/D02z0krtPP3/U4X02CC24sXnW
         K6gNAqFL4z4blHGhDQwOBd9nkVI9sKcXehGxmStbHpTLqsqeH2afAqa5e1CojN5TX1Ud
         RZSsWKzLRZ8+0mIt89SoRohIXKhfN7fsyE8WdJ2m1jaxKJa4KQ2aYP9UPQSbPZJVprpT
         BFfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711626265; x=1712231065;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3y+KXWEfWfpEojVj1X6/3zY4ZRTAAz5xP7hkSyIkL50=;
        b=FsZu/dxKWrjkApJ86yXkVc6D60Sr6mItsNB6lA8JlF56hEpj+kR/x1kmH6BuUb1e3W
         /qwUjYE0UJYytWnxrTqQyTQWt58uqOhRHlfM1iQTOpnYMkwjYJGP9973e5Fctf7TxsIV
         ZZaw3xXy8MeK5wPszHEDaJQ23NdODDXZfhVrSGTZ2LmnPraDt1bQ+WhdPZ2WuKe2uOhU
         Nd5B/CWvu4/GtFq4LxJJpADRG9rGsLcBOi19aSfHVchFj6ejh788qPVUQmhKdBk0D6QD
         y0dBthdoOean8pmnz3raAvh9dgM4MJLeuJxcMz0bmKAP3jkBtavK9gLBzH1jQWwRG26Z
         Fzxw==
X-Forwarded-Encrypted: i=1; AJvYcCV6Hvh+LG4FT7AkoTJ+ux0T83u6xKol4Lay3JTL7aJ9J0PuWSs81gckpXL/WOG5of7hksZNWp2MOdqLlAU5LG24PW2p3hFBVRV3ptlFww==
X-Gm-Message-State: AOJu0YwMiNGeXkRmVvZXBN2GSvI65wKNhjeSRMZStecZ+uUX79TDXlly
	DEv6NHy8nc5Xg85Zaqy/9LKx0HM/kxy6u8a6DvCW0qGn4cn6Mn6LxL/+xddpSJg=
X-Google-Smtp-Source: AGHT+IFrnp2aA60pBw9adQsCXolLsZljvoQE3UncP7YmpW9r3g7SXnP4q7P/j/1pSVSSJCYJQBZ1rw==
X-Received: by 2002:a05:6512:11f0:b0:515:9eb1:5458 with SMTP id p16-20020a05651211f000b005159eb15458mr1551911lfs.32.1711626265181;
        Thu, 28 Mar 2024 04:44:25 -0700 (PDT)
Received: from [192.168.50.4] ([82.78.167.8])
        by smtp.gmail.com with ESMTPSA id i9-20020a0560001ac900b0033e41e1ad93sm1555315wry.57.2024.03.28.04.44.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Mar 2024 04:44:24 -0700 (PDT)
Message-ID: <483d4ba2-8fab-4ab2-81ef-395e36fc8b30@tuxon.dev>
Date: Thu, 28 Mar 2024 13:44:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.10.y-cip 11/36] irqchip: Add RZ/G2L IA55 Interrupt
 Controller driver
To: Pavel Machek <pavel@denx.de>
Cc: nobuhiro1.iwamatsu@toshiba.co.jp, cip-dev@lists.cip-project.org,
 biju.das.jz@bp.renesas.com, prabhakar.mahadev-lad.rj@bp.renesas.com
References: <20240327081756.2228036-1-claudiu.beznea.uj@bp.renesas.com>
 <20240327081756.2228036-12-claudiu.beznea.uj@bp.renesas.com>
 <ZgQL8xwYwbaRdX4N@duo.ucw.cz>
From: claudiu beznea <claudiu.beznea@tuxon.dev>
Content-Language: en-US
In-Reply-To: <ZgQL8xwYwbaRdX4N@duo.ucw.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 28 Mar 2024 11:44:38 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15477

Hi, Pavel,

Thank you for your review!

On 27.03.2024 14:07, Pavel Machek wrote:
> Hi!
> 
>> +++ b/drivers/irqchip/Makefile
>> @@ -51,6 +51,7 @@ obj-$(CONFIG_RDA_INTC)			+= irq-rda-intc.o
>>  obj-$(CONFIG_RENESAS_INTC_IRQPIN)	+= irq-renesas-intc-irqpin.o
>>  obj-$(CONFIG_RENESAS_IRQC)		+= irq-renesas-irqc.o
>>  obj-$(CONFIG_RENESAS_RZA1_IRQC)		+= irq-renesas-rza1.o
>> +obj-$(CONFIG_RENESAS_RZG2L_IRQC)	+= irq-renesas-rzg2l.o
>>  obj-$(CONFIG_VERSATILE_FPGA_IRQ)	+= irq-versatile-fpga.o
>>  obj-$(CONFIG_ARCH_NSPIRE)		+= irq-zevio.o
>>  obj-$(CONFIG_ARCH_VT8500)		+= irq-vt8500.o
>> diff --git a/drivers/irqchip/irq-renesas-rzg2l.c b/drivers/irqchip/irq-renesas-rzg2l.c
>> new file mode 100644
>> index 000000000000..cf99cd6b41c4
>> --- /dev/null
>> +++ b/drivers/irqchip/irq-renesas-rzg2l.c
>> @@ -0,0 +1,394 @@
>> +#define IRQC_IRQ_START			1
>> +#define IRQC_IRQ_COUNT			8
>> +#define IRQC_TINT_START			(IRQC_IRQ_START + IRQC_IRQ_COUNT)
>> +#define IRQC_TINT_COUNT			32
> 
> The code hardwires assumption that interrupts are IRQ_START
> .. TINT_START .. TINT_START+TINT_COUNT.

IRQ 0 is NMI. I missed to add it in the diagram I attached to patch 10. The
intention there was to describe the hierarchy b/w the IRQ controllers.
Sorry for that.

The interrupts in interval [IRQC_IRQ_START, IRQC_IRQ_COUNT] (IRQ
interrupts) are interrupts for which dedicated pins are available. In the
above diagram (borrowed from hardware manual) these are described though
IRQ0-7. These dedicated pins have 1:1 mapping w/ the IRQs that IA55 IRQC
routes to GIC.

The interrupts in interval [IRQ_TINT_START, IRQ_TINT_COUNT] (TINT
interrupts) are interrupts that could be mapped to any GPIO pins.
In the above diagram GPIOINT0-127 specifies that any of the 127 pinctrl
pins could be mapped to these TINT interrupts.

IRQ interrupts and TINT interrupts and are configured differently in the
IA55 registers.



                                     ┌──────────┐          ┌──────────┐
NMI -------------------------------->│          │ SPIX     │          │
                                     │          ├─────────►│          │
                                     │          │          │          │
                                     │          │          │          │
             ┌────────┐IRQ0-7        │  IA55    │          │  GIC     │
Pin0 ───────►│        ├─────────────►│          │          │          │
             │        │              │          │ PPIY     │          │
...          │  GPIO  │              │          ├─────────►│          │
             │        │GPIOINT0-127  │          │          │          │
PinN ───────►│        ├─────────────►│          │          │          │
             └────────┘              └──────────┘          └──────────┘

> 
>> +	raw_spin_lock(&priv->lock);
>> +	if (hw_irq >= IRQC_IRQ_START && hw_irq <= IRQC_IRQ_COUNT)
>> +		rzg2l_irq_eoi(d);
> 
> I'd do "< IRQC_TINT_START" here.

hw_irq 0 is NMI. IRQs IRQC_IRQ_START-IRQC_IRQ_COUNT are IRQ interrupts and
IRQs IRQC_TINT_START - IRQC_NUM_IRQ are TINT interrupts. These are
configured differently thus, the need to differentiate here.

> 
>> +static void rzg2l_irqc_irq_disable(struct irq_data *d)
>> +{
>> +	unsigned int hw_irq = irqd_to_hwirq(d);
>> +
>> +	if (hw_irq >= IRQC_TINT_START && hw_irq < IRQC_NUM_IRQ) {
> 
> And here.

Same here.

> 
>> +	if (hwirq > (IRQC_NUM_IRQ - 1))
>> +		return -EINVAL;
> 
> '>= IRQC_NUM_IRQ' would be more clear here.

This could be updated, for sure. I don't know exactly the procedure for
that: should a patch be first published to upstream kernel and then here or
would you prefer to have it directly published here?

> 
>> +static int rzg2l_irqc_init(struct device_node *node, struct device_node *parent)
>> +{
>> +	struct irq_domain *irq_domain, *parent_domain;
>> +	struct platform_device *pdev;
>> +	struct reset_control *resetn;
>> +	struct rzg2l_irqc_priv *priv;
>> +	int ret;
>> +
>> +	pdev = of_find_device_by_node(node);
>> +	if (!pdev)
>> +		return -ENODEV;
>> +
>> +	parent_domain = irq_find_host(parent);
>> +	if (!parent_domain) {
>> +		dev_err(&pdev->dev, "cannot find parent domain\n");
>> +		return -ENODEV;
>> +	}
> 
> I believe you'll need to put pdev in this and following error paths.

You're talking about put_device(&pdev->dev)?

I agree, that should be done on error path.

Would you prefer to post the patch here directly or 1st to the upstream
kernel and then backport it?

Thank you,
Claudiu Beznea

> 
> Best regards,
> 								Pavel

