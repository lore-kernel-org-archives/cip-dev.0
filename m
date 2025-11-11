Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16623CCF9E3
	for <webhook@archiver.kernel.org>; Tue, 11 Nov 2025 08:47:37 +0000 (UTC)
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.13323.1762850852589171445
 for <cip-dev@lists.cip-project.org>;
 Tue, 11 Nov 2025 00:47:33 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=VClfBqQ7;
 spf=pass (domain: tuxon.dev, ip: 209.85.128.54, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-477619f8ae5so29496315e9.3
        for <cip-dev@lists.cip-project.org>; Tue, 11 Nov 2025 00:47:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1762850850; x=1763455650; darn=lists.cip-project.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bHBGJ8/xYN1p9PIuL972XSEgXSfg7WzfRuV5k0ny1+8=;
        b=VClfBqQ73c0jEFhNQLCUyaKl3l4pWgJluPw9GU/hRcW8PrIpxU6Qiem3Q9P1cwHNxm
         F9u5TeFWUKIY/BGsc/v8NCWCLfU97RWhDAcQm8QURfa9XGhgenQKdWHVrge49gg7IRDI
         OV/mYQrBp6GJxX50IObdf1NBD4U7nIO6C6Txpb/Q477U5z4jLCplHYu7fPSubt0BF9Ha
         k7zl6sEvTbURSCkCJnIaDadecp/jKdzG6QeTbQbouN8Wr4SZBJ9UmpJH+5VYqz6hi8nh
         aPAn/WofTW73jbGNR5/mDLSUaptRydSUdeCB6UT1VYmQEg9mgjhbswneizWh1f0jPTLu
         xuaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762850850; x=1763455650;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bHBGJ8/xYN1p9PIuL972XSEgXSfg7WzfRuV5k0ny1+8=;
        b=kUCW1IhrFhx7TzyO0GZ6efSuImgGICBSEZy7Z3f/DrA7yxl/VyFRiGyf58aIVIr48c
         8Eg9DQS0ZjRDZf3Rz66+/+E65g67r6a8eTeRZudHQfrXmchoHxKQAt5h4njYVznfrVdL
         N31O8FLH0wx4l6NuodwOVWFSNdt6zpyn61pxPoJgNnKkVUbsJTwka6LyTuTWKYIy0LWL
         P+GqRywICAEgT1r4d0QGEUmuZ9dPa4jzB8HoNH15r4B338spMQuknWoYNcAURwUzmc90
         Nvd1VXQJQ2QdDyHHpuscGqq2jaBF/Qi9Ev6gkQ/+aGsbnrdXzBCmnOLUIrWds+FYAaNA
         CwOw==
X-Gm-Message-State: AOJu0Yxwp8rEcQEHZCUXyDTPsyTEM4XKFXt3AHMjIGRHnSL21sTYE/+4
	k315igskAJuPKallETmUGrlYryGHUk55pFkbvWCj0mcmsYe4N6q09Q4AoLzCFw12TfWPnNBsu8V
	X+UW+E1k=
X-Gm-Gg: ASbGncsieiptX9gK3jAQTYjsKIhEfoq/Rpsq8nHj+UFGQb7+MQyWKPMKR2jgeOV9/L4
	qhWlgVllBMZzDIx0y8SMMZ3LpGNUWdK9/BaBKk2YCDidiqH2Hnl8CXqbybyplfA2slog+CaSoW6
	KStbk8W31Ww5UeQjsH7s4sYgxG86YYPiPCTq+2iYx1gMWZ631ZWRa9APgNC4YYlOibkqeoDsnlR
	nPWALOw/we6OM5KoxW5KpdcP5H110uC7nXIWNfi2OZ7WAqsJ67EUPoTP7SLky4JZ+cladI2p14C
	dL7zkPTFq5RfT1ZTLN5zpPGFMwlcNEceYICVtqS6BUY/yZiv/Uss2UeonesCxLchEolCyIiO8ST
	8yOsKf334OKhROp8mlBej8nvjwPOMuVnc3ozNKYaN2ZA2Y209WbjmU30rikuD44qvELAvCG6ZU1
	LAObY7Jifmlu/0+HM3T+w=
X-Google-Smtp-Source: AGHT+IGIszjqJRPkb0IBHDtGDuLV+atl2Z2tr2nCM32t5cjm2UXBRRTlgY9B19ucZ+s+U9mtiH5Qpg==
X-Received: by 2002:a05:600c:1ca7:b0:46f:b43a:aee1 with SMTP id 5b1f17b1804b1-477732a9d90mr105001565e9.38.1762850850235;
        Tue, 11 Nov 2025 00:47:30 -0800 (PST)
Received: from [192.168.50.4] ([82.78.167.134])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42b2dd927d5sm20080161f8f.24.2025.11.11.00.47.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Nov 2025 00:47:29 -0800 (PST)
Message-ID: <03c95905-3b52-4d09-87c5-a26dc79d1dd8@tuxon.dev>
Date: Tue, 11 Nov 2025 10:47:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev] [PATCH 5.10.y-cip 00/22] RZ/{G2L, G2LC, G2UL, G3S,
 Five, V2L}: Backport MSTOP support
To: cip-dev@lists.cip-project.org
References: <20251106081218.2574950-1-claudiu.beznea.uj@bp.renesas.com>
 <aQz1pgHaEQNgfdKa@duo.ucw.cz> <1875B18477989308.416970@lists.cip-project.org>
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
Content-Language: en-US
In-Reply-To: <1875B18477989308.416970@lists.cip-project.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 11 Nov 2025 08:47:37 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20492

Hi, Pavel,

On 11/7/25 12:06, claudiu beznea via lists.cip-project.org wrote:
> Hi, Pavel,
> 
> On 11/6/25 21:23, Pavel Machek wrote:
>> Hi!
>>
>>> Series backports the MSTOP (Module Stop) support for the Renesas
>>> RZ/G2L, RZ/G2LC, RZ/G2UL, RZ/G3S, RZ/Five, RZ/V2L SoCs.
>>>
>>> The purpose of MSTOP is to reduce power consumption by stopping
>>> unnecessary module's functions.
>>>
>>> If any master accesses a module that has the clock stopped and the
>>> MSTOP bit set, a bus error will occur.
>>>
>>> Due to this, to avoid CPU generating synchronous aborts, changes
>>> to PM domain specific code were needed. The changes backported in
>>> this series were adjusted to be executed only for the above
>>> mentioned Renesas SoCs.
>>>
>>> Please share your thoughts on this approach.
>>
>> This is a bit more intrusive than I'd like. dev_pm_domain_detach()
>> changes API and now we have to modify unrelated drivers to fix it up.
> 
> All the bus drivers were updated to avoid issues described in
> https://lore.kernel.org/all/20251106081218.2574950-6-claudiu.beznea.uj@bp.renesas.com/
> 
>>
>> How much power does it save?
> 
> I don't have numbers here. It is what HW manual sates.
> 
>> Do we really need this? 
> 
> There are issues with the way the device is attached/detached to its PM
> domain w/ or w/o the MSTOP support as long as the drivers are using
> devm helpers while the power domain attach/detach calls in bus drivers are
> not. This is because devm cleanup helpers are called after the device is no
> longer part of a PM domain (due to the dev_pm_domain_detach() calls in bus
> drivers remove functions or bus drivers probe functions (on the failure
> path)). And the cleanup helpers may access IP registers while power is not
> applied.
> 
> It just started to be more visible on Renesas devices with the addition of
> MSTOP because any master access to an IP having MSTOP set generates bus errors.
> 
> E.g. w/o MSTOP support, if a device is part of a clock PM domain, it uses
> devm_pm_runtime_enable() in its driver, if stressing unbind/bind I can
> reach the point where the rpm_idle() tries to runtime resume the device (in
> the unbind cleanup phase) while its clocks are not anymore part of its PM
> domain. If the driver has it's own runtime PM APIs as well that tries to
> access the IP registers, rpm_idle() will call driver RPM APIs and those
> will fail because the clocks are no longer enabled though PM domain. The
> issue is explained in the description of
> https://lore.kernel.org/all/20251106081218.2574950-6-claudiu.beznea.uj@bp.renesas.com
> 
>> Could it be done
>> without changing semantics of existing functions?
> 
> Other approaches I've tried on mainline are:
> 
> 1/ open/close a devres group in bus drivers probe:
> -
> https://lore.kernel.org/all/20250215130849.227812-1-claudiu.beznea.uj@bp.renesas.com
> 
> 2/ add devm_pm_domain_attach() to have the dev_pm_domain_detach() call in
> devres cleanup phase:
> -
> https://lore.kernel.org/all/20250526122054.65532-3-claudiu.beznea.uj@bp.renesas.com
> -
> https://lore.kernel.org/all/20250606111749.3142348-3-claudiu.beznea.uj@bp.renesas.com
> 
> Please let me know if you have other suggestions.

Could you please let me know if you have any suggestions to help progress
with this series?

Thank you,
Claudiu

