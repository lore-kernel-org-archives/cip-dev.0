Return-Path: <yoshitake.kobayashi.x25@mail.toshiba>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A9CDCEFD1D
	for <webhook@archiver.kernel.org>; Tue,  6 Jan 2026 23:01:38 +0000 (UTC)
Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.183])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.92738.1767714362057032170
 for <cip-dev@lists.cip-project.org>;
 Tue, 06 Jan 2026 07:46:02 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@xs4all.nl header.s=xs4all01 header.b=TtzInC68;
 spf=pass (domain: xs4all.nl, ip: 195.121.94.183, mailfrom: mark.kettenis@xs4all.nl)
X-KPN-MessageId: 43534ba1-eb15-11f0-be9a-005056992ed3
Received: from smtp.kpnmail.nl (unknown [10.31.155.6])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id 43534ba1-eb15-11f0-be9a-005056992ed3;
	Tue, 06 Jan 2026 16:35:00 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xs4all.nl; s=xs4all01;
	h=subject:to:from:message-id:date;
	bh=nPsnwIvNJZfZl6Ue6gHviHxOLLQ24w4b336Fg0ueJRY=;
	b=TtzInC68wJXsfr5UWL6nld2gzwCXx8WFZ67tLi8lU+wNQ2lsZbnw6kRv/K8/PulXu4SLs0XQcGg+6
	 D2dVXB669gP6AtzZ9NNr3G8fc7upkpUgsLfC8Siu6bSdzDVvjiCKl4S8sf9pKbYpRs79tNF7U0zyjC
	 PcDewTrSm3k5DMmN6i0ZVmKQWzKKknV9+xhpv2cVl3LuOUEQYO185u4PWG/K4DsHMffv4qnmMbK8Gn
	 8gZhcnLiPGDX1a4Tjfq19Vm0gPuUjM8I1fv1kl5gBaaxID1jgBmNmvOK2+yrNFVBlt3AqvrvoUHOhb
	 I38tOrWILrVMacR0YLBd61Ug1gj/Z2w==
X-KPN-MID: 33|ahTo6/xTWEhQQNPwwIr987qDgesKlmcJORAa+HYQDAVOkwRjOVrvpDMHvagT3vy
 i7u9nvLQg4CTaQ+IsJB4V0ifiTAJBH5V6deu0xmqfKHI=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|yf0a9eMZ/EU6Hi1segogGjyaykBK7XM87E+pz8ocDB7EnW0M8DqO7gL3yem1F+L
 82qnM/dMdjNrvh1OAKJiFAg==
X-Originating-IP: 80.61.163.207
Received: from bloch.sibelius.xs4all.nl (80-61-163-207.fixed.kpn.net [80.61.163.207])
	by smtp.xs4all.nl (Halon) with ESMTPSA
	id 3f4e7069-eb15-11f0-bff6-00505699772e;
	Tue, 06 Jan 2026 16:34:55 +0100 (CET)
Date: Tue, 06 Jan 2026 16:34:53 +0100
Message-Id: <87ms2qah5u.fsf@bloch.sibelius.xs4all.nl>
From: Mark Kettenis <mark.kettenis@xs4all.nl>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: u-boot@lists.denx.de, xypron.glpk@gmx.de,
	cip-dev@lists.cip-project.org
In-Reply-To: <c999bfc3-e95c-4a1a-98a2-952ae66959d1@siemens.com> (message from
	Jan Kiszka on Tue, 6 Jan 2026 14:47:30 +0100)
Subject: Re: Drop default y from CONFIG_EFI_GRUB_ARM32_WORKAROUND?
References: <c999bfc3-e95c-4a1a-98a2-952ae66959d1@siemens.com>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 06 Jan 2026 23:01:38 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21392

> Date: Tue, 6 Jan 2026 14:47:30 +0100
> From: Jan Kiszka <jan.kiszka@siemens.com>

Hi Jan,

> Hi,
> 
> it seems that some kernel configs can cause problems with the
> CONFIG_EFI_GRUB_ARM32_WORKAROUND. Namely, 6.1-cip and 5.10-cip with its
> current defconfigs [1] no longer boot on the BeagleBone Black (other
> boards still need validation), both with the more recommendable
> systemd-boot and grub. I do not have the motivation to debug the reason
> in the kernel / its config, given that everything works fine once the
> firmware behaves according to the UEFI spec.
> 
> Meanwhile, grub reached 2.12 now which is far away from the old, broken
> version of 2019. So, should we rather make this workaround opt-in in 2026?

This isn't just about GRUB though.  There is also the issue with the
the non-architected caches that are typically found on systems that
use Cortex-A9 cores such as i.MX6.

The OpenBSD bootloader used to have the same problem as those older
versions of GRUB.  I fixed that back in 2019, and there shouldn't be
any users left with a broken version.

> [1]
> https://gitlab.com/cip-project/cip-kernel/cip-kernel-config/-/blob/cda3f5841dec33b81f24cedcc32ea09bb58bbfb5/6.1.y-cip/arm/cip_merged_defconfig
> 
> -- 
> Siemens AG, Foundational Technologies
> Linux Expert Center
> 
> 

