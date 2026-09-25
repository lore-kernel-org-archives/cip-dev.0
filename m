Return-Path: <hirotaka.motai@miraclelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A3B0C9830E
	for <webhook@archiver.kernel.org>; Fri, 25 Sep 2026 06:56:38 +0000 (UTC)
Received: from mail-pj2-f41.google.com (mail-pj2-f41.google.com [74.125.227.169])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.2791.1790319394037228198
 for <cip-dev@lists.cip-project.org>;
 Thu, 24 Sep 2026 23:56:34 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@miraclelinux-com.20251104.gappssmtp.com header.s=20251104 header.b=U0MBhVOn;
 spf=pass (domain: miraclelinux.com, ip: 74.125.227.169, mailfrom: hirotaka.motai@miraclelinux.com)
Received: by mail-pj2-f41.google.com with SMTP id 98e67ed59e1d1-3a0b18f811cso447214a91.0
        for <cip-dev@lists.cip-project.org>; Thu, 24 Sep 2026 23:56:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=miraclelinux-com.20251104.gappssmtp.com; s=20251104; t=1790319393; x=1790924193; darn=lists.cip-project.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xTv+xg8x1j5DeF6/JMRpspyKjEq/X7NY15zj4nFqFck=;
        b=U0MBhVOnU2+ijVSsU2HulWzWm+CS2yNCvnqjDQ4ZO2VTphF3EckAecRLTQ51qzKWYH
         YUrfNOmR87gkq6cqYH/yJizdhiIxEow+JXCUI7CysxZkzYfPglVA3Br3uU1Jt/8hk3Kp
         geY6k3yyx/lMTDJncK4ukhSvxmiCymYLBVN4R9y9L3qdTO3SLEk9Gfbnp2j3JV71J4vC
         piEZ8k13L+glaSlurV8JpDjvf44kSonwOICb3qqD8z2Mu8EO/QsdqeIi0b83cIwTV9Xs
         haAwFkqtPWWsTUiaFr1DbUrbY5qx1r0te2IHYvhfnqHfsXBIwPX3+FPOEyuSuqcshe1T
         nyDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790319393; x=1790924193;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xTv+xg8x1j5DeF6/JMRpspyKjEq/X7NY15zj4nFqFck=;
        b=141+xXY8+rYr6V48pFsRj2uby/qaa0XsAFtu1+GvFJbIQlGYb8i74jJ+E4wgUGYF5F
         +fI7Dzm0iHh0GeUJ6dCTtGsQA/fAxgRB2NJor9awFe/urtX+ufjgjE0Cykd+zO1JGTf1
         Y+7NT3ix3wKBiJKnz4LCtRoqOLLdrvpgWxl0zrGSmrJpGyirMJ5h4DamfIUzOCDzGZye
         wV9vIJSDxaiszytvJgL10jH5vg81sQd7fJ3g87OVTFxRxtngUvy+40Iu7mnxQQ90XjG2
         7MsooO2nTAavCJdJ5NsVrXRLes9Stu/7SF8W6+zTEjvQ67UI2uet/W7/LuPG9Tk2FPb0
         qBVg==
X-Forwarded-Encrypted: i=1; AKwUvBx41aqLaXLUtsidsREhyxV4r6BtcI0spSIuCErSdKZeJV7dejrGlsNz3iOgblCyS0AsVPpObPk8@lists.cip-project.org
X-Gm-Message-State: AFuF++n9isG8K6Tsii9yeQ6jDUmbbVxM60vwld5xXddufl0GZi0VgQSw
	YHdkNxI1W1UpWiu+ti1GuYkIuW3mnS5N3eZ2/uQHc6UUxRZkDD98ezdtqCdsZEf0SWg=
X-Gm-Gg: AYBFou27AgUC0NYhslu8c3cVOuS/3wIeasskdAGwH1cvFcv6Rg5Ze43zjHYrI7Vqd/X
	kvNZ4LfF3jAHAQc1Z43onQCEb6wmdObdeFbv2MbNXpqL3OTxvDKT4LdkHvyUy7V4xAxIdnXPDON
	pySOetEUzPLejNfmpWjIMe7bYAuR6SYwUdKgQ5FPidHZLi4QP++hKz6ZMd/i3ERCBC8LM5nKJrA
	PPwrJ+dxFdCtuOOnQ8RzNbYkgTh/wWbOAU4JSVJMS3df0BHQreHi43Hy8KfVEHtx6aZWplHAZQz
	1pNPgGiXFUC69zO56CltkhPvhxluOyCY2uexJ0uLz0pLF9fwwW4Dvl//AKKRefrXRGKKpicxwaC
	HjepsW1ypa+5GX1iakzdgjdAzSve1VhK6bokEdBcyDqk0PsLM6FnQssTPQYRHQXigJCU+JNZqBj
	Y0xomIxk1Igma2NJy+YJvHU0nE02zdPBaWCiuKZyzrfcVIzF+qa4yWic5xm8Ul/ZgFxSJpX8MgG
	X/emK/RgwoqxwDKqY1V3eLHZ0OSTuSJRfVirV5dZ8IYiyfhSa0SByog3IACyg==
X-Received: by 2002:a17:90b:2809:b0:39e:5de4:26bf with SMTP id 98e67ed59e1d1-3a098b98d86mr4122132a91.11.1790319393235;
        Thu, 24 Sep 2026 23:56:33 -0700 (PDT)
Received: from [192.168.0.117] (FL1-133-203-46-83.tky.mesh.ad.jp. [133.203.46.83])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a0c3f74e5bsm842175a91.5.2026.09.24.23.56.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Sep 2026 23:56:32 -0700 (PDT)
Message-ID: <243f9dd8-960c-4c9d-ab65-4821d8aca1d7@miraclelinux.com>
Date: Fri, 25 Sep 2026 15:56:31 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev] lab-cip-cybertrust
To: quirin.gylstorff@siemens.com, cip-dev@lists.cip-project.org
Cc: hiraku.toyooka@cybertrust.co.jp
References: <c9a0c64f-5341-4983-8020-32144e5fd0ca@siemens.com>
Content-Language: en-US
From: Hirotaka Motai <hirotaka.motai@miraclelinux.com>
In-Reply-To: <c9a0c64f-5341-4983-8020-32144e5fd0ca@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 25 Sep 2026 06:56:38 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24342

Hi Quirin,

Thank you for sharing the error status.
We'll check it out.
Since it's a holiday week in Japan right now, we might not be able
to get back to you until next Monday or later...

Best regards,
  -- Hiro / Cybertrust Japan

On 2026/09/24 20:04, Quirin Gylstorff via lists.cip-project.org wrote:
> Hi,
> 
> I disabled qemu-03 as it had three times in the row the same error:
> 
> *Job error:* Decompression subprocess exited with non-zero code: unxz: (stdin): Compressed data is corrupt
> 
> https://lava.ciplatform.org/scheduler/job/1514767
> 
> https://lava.ciplatform.org/scheduler/job/1514772
> 
> https://lava.ciplatform.org/scheduler/job/1514774
> 
> 
> The test works one qemu-cariad-01:
> 
> https://lava.ciplatform.org/scheduler/job/1515037
> 
> Best regards,
> 
> Quirin
> 
> 
> 
> -=-=-=-=-=-=-=-=-=-=-=-
> Links: You receive all messages sent to this group.
> View/Reply Online (#24307): https://lists.cip-project.org/g/cip-dev/message/24307
> Mute This Topic: https://lists.cip-project.org/mt/121407550/4984330
> Group Owner: cip-dev+owner@lists.cip-project.org
> Unsubscribe: https://lists.cip-project.org/g/cip-dev/unsub [hirotaka.motai@miraclelinux.com]
> -=-=-=-=-=-=-=-=-=-=-=-
> 

