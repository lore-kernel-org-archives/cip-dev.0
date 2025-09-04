Return-Path: <kazunori.kobayashi@miraclelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45BA4CA1014
	for <webhook@archiver.kernel.org>; Thu,  4 Sep 2025 03:33:07 +0000 (UTC)
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
 by mx.groups.io with SMTP id smtpd.web11.31108.1756956783222198880
 for <cip-dev@lists.cip-project.org>;
 Wed, 03 Sep 2025 20:33:03 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@miraclelinux-com.20230601.gappssmtp.com header.s=20230601 header.b=vYmK1NX3;
 spf=pass (domain: miraclelinux.com, ip: 209.85.210.172, mailfrom: kazunori.kobayashi@miraclelinux.com)
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-7726c7ff7e5so551261b3a.3
        for <cip-dev@lists.cip-project.org>; Wed, 03 Sep 2025 20:33:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=miraclelinux-com.20230601.gappssmtp.com; s=20230601; t=1756956783; x=1757561583; darn=lists.cip-project.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vNxjhjmWxf/deVPnDPC9BzjD+1ZYCRtEIkj0SzVFaEw=;
        b=vYmK1NX3cAsxNOlJVJMltvUbPSOGFGV4r8EnEks6pb5kLr2+euZO5JiP/efEkwx4yN
         rpQmh/ZUJOLq1uZFfBB9bWU8uMJMUTrkd9OvsKHDhk3N7zBzpzbgH1eZSX7jm+fS4xKO
         fJesRWRGCNZ8Q9rehFVs/HkfdVK2oC2+6yc6oppTQyca9qQKWSydkBFqMM5dM/8/2FF2
         yKAZcIGIQuF2G980cvlUzEmr7UH1CXcZM7HheLbeSsAu8R3iiWSqpqaxEOpGVDLCWCho
         1Er0w9yBDqtfpQyuuWgdTQPThpxOmxG8/Of4rkjO22/kK6xlBIBUt4HvX3vGMDwZftMg
         R26A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756956783; x=1757561583;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vNxjhjmWxf/deVPnDPC9BzjD+1ZYCRtEIkj0SzVFaEw=;
        b=isbulvCIQRrT4aQD9IDSrCbEgJ4EJqHeUPk/MgzilK8Ugl4Ev22NOoscT0suaLWEap
         9mIuumHcsU4k9yiNOFjZdTo+rmxzQ8fVGY7+pnCZtxpbuEq9aaxh6YWlcX5leGK1l+TF
         dJPsGXoe7tAJKLN5LyjrJK/AgtDHGsT5VTrufwLiJ3jEl62d/ftIP6Hq010seBzGjeMD
         vb9XJ/VAClJOMu9OgTJBB/FRXi9pDG/pES5GO9JgQ9PBIx5k4Tu/oMDOPxFQgKnr58NI
         DtuDOvA3FJ1GljCASUCIQb6KuQnhLRl1f5+zZjw0Xd2Szhvxg8jLlzwo5PEVAnMEwi41
         gEKg==
X-Forwarded-Encrypted: i=1; AJvYcCWSIKj/y6w64sNbbF9Qq8tTrv6Usn6pV6gI5VLK/6uFTn3NzmHq7TQpMR9cbIsPYnU65EZIfbZp@lists.cip-project.org
X-Gm-Message-State: AOJu0YwtRBD8eOEEpRKUe90bVn7lglI0dYCpvFMEt6m8sCMtJx4ytivJ
	yvb5rcdvbfivuuv1Jbgb3EicL0PSaCWSLmiUqpXaIubqU9b0vt6998P8bostEBPgGLs=
X-Gm-Gg: ASbGncujWdFL9VvYdDe7UP5DVBcMZzBV7w0QA5Cmh/FNKlrv1PFbp9zGYp6tTSWCC1G
	d9CUzYE8skRmo3FVmgx3rjfvRp2VD+LqP11eQpol4P1SrxvMBQ2NELbQBzX1Ocppt0bq0wq2ssm
	CoSmnkRMdAfHz1c3KQ2WBGF4NzMfR0T5NnqgAl7W31P/Ks8OWvbdC7MrFoQouONYuM45ojrHxfk
	UIGolyhnhyhqEoZiARXWZXXNxygWwVmlUFjqaMauXmokytcGdML1lUZwFkZvo+eab8j6dYSVee7
	9rc5ZjeLtXUGh9ETeZG7LKUPa9QNO1DtM68JEXN07R1xVDFpwY8hFOwoOo4yEBDHpCP0F+u1IRP
	U+3GIMfn8Kcmhjx1gwUs7nQLlGs/sjGJnhuylxVJ8pso9oRah3jKrU4zryo/I1wGHuui9aTYnH8
	cC8ByhwoWcvGk9pLUogd+C9GM=
X-Google-Smtp-Source: AGHT+IHDxLIDmuPHwr9wFf9SkEo9wyfyiuqbS9QQDhSbkK0aCS35cJXIc9bNpvajNSxjYopyi6IC4A==
X-Received: by 2002:a05:6a20:2445:b0:24c:48f3:3fdb with SMTP id adf61e73a8af0-24c48f341c8mr403563637.39.1756956782556;
        Wed, 03 Sep 2025 20:33:02 -0700 (PDT)
Received: from [192.168.11.7] (133-149-217-149.east.dxpn.ucom.ne.jp. [133.149.217.149])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7722a4b99fasm18260126b3a.57.2025.09.03.20.33.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Sep 2025 20:33:02 -0700 (PDT)
Message-ID: <8a9b11aa-4b03-463d-aa51-f53d2abed51b@miraclelinux.com>
Date: Thu, 4 Sep 2025 12:32:58 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev] [ANNOUNCE] Release v4.19.325-cip123
To: Ulrich Hecht <uli@fpond.eu>,
 "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
 "pavel@denx.de" <pavel@denx.de>,
 "jan.kiszka@siemens.com" <jan.kiszka@siemens.com>,
 "masami.ichikawa@cybertrust.co.jp" <masami.ichikawa@cybertrust.co.jp>,
 "chris.paterson2@renesas.com" <chris.paterson2@renesas.com>,
 "nobuhiro1.iwamatsu@toshiba.co.jp" <nobuhiro1.iwamatsu@toshiba.co.jp>
References: <1602384696.84101.1755530487321@webmail.strato.de>
 <42de8250-d98b-40e5-9e8a-d6bbb1ca8b6b@miraclelinux.com>
 <165242228.250961.1756910318537@webmail.strato.de>
Content-Language: en-US
From: Kazunori Kobayashi <kazunori.kobayashi@miraclelinux.com>
In-Reply-To: <165242228.250961.1756910318537@webmail.strato.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 04 Sep 2025 03:33:07 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20004

On 9/3/25 23:38, Ulrich Hecht wrote:
> Thanks for the report.
>
> Looks like it's missing "dma-mapping: add generic helpers for mapping sgtable objects". I pushed a backport to the rc tree (https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git/log/?h=linux-4.19.y-st-rc), please check if it works.
>
> I have also added omap2plus_defconfig to my local build configs.
>
> CU
> Uli

Thank you. I could confirm the compilation with CONFIG_VIDEO_OMAP3 
enabled was passed with this backported patch.

We, the Cybertrust OSS development team, realized CONFIG_VIDEO_OMAP3 is 
out of scope of the CIP kernel in this post. Currently we are discussing 
if we have to continue using this config and propose cip-kernel-config 
supports it in a formal way. We will contact you separately if needed.

Regards,
Kazunori

-- 
Kazunori Kobayashi
Cybertrust Japan Co., Ltd.
https://www.cybertrust.co.jp/


