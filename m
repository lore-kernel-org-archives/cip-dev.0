Return-Path: <yoshitake.kobayashi@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E33AEC7115B
	for <webhook@archiver.kernel.org>; Fri, 20 Jun 2025 06:16:34 +0000 (UTC)
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
 by mx.groups.io with SMTP id smtpd.web10.68.1750391597016987904
 for <cip-dev@lists.cip-project.org>;
 Thu, 19 Jun 2025 20:53:17 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=LAwdo31V;
 spf=pass (domain: gmail.com, ip: 209.85.210.182, mailfrom: zaq14760@gmail.com)
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-7426c44e014so1133301b3a.3
        for <cip-dev@lists.cip-project.org>; Thu, 19 Jun 2025 20:53:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750391596; x=1750996396; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QQes6Cas/O2Il66TXoZhd9SrmsyHWm0zoxLufdtfzV8=;
        b=LAwdo31Vgtyb8xsWFRNKj3eGyh8WGkIQ3oKoHjRJyJluSIUtz0bxN1+VMMYWTMT71J
         k0rmJjJ6n0tUkMd9+yrvPaBLuGJcI7HEvKiONQRDfpFHdX/WBxV1QNtA0wwBm9rbBp+Q
         lN13aud1WSqKBXAjgi67oGiYFBpVI4BjRAKilVpShwSDxm+PVirlWJwrD/Z/D+8JNpJY
         l2iVG9F9ywCYQJgWmbUUyj/PR5SjxVdfwefqhyxHR158u1UWI8MATTacDNVsJ4Jspt67
         a6FyLnMRkhp3LUsvTGfLcrfCyvzKVigsudP5Q/7TqwpIflD7h3D/UwQx0+fmLJVyYHMP
         9VJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750391596; x=1750996396;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QQes6Cas/O2Il66TXoZhd9SrmsyHWm0zoxLufdtfzV8=;
        b=g4K92X3vgaUh1t2vBq7I5cOQQ3wpYcNyKl4qx7B4NA/87Sfune+HaK7joVPVmqTJ0U
         8vEXM7WE+dWiJi4N5hRSX0J3o3uFDBB+nVVSG8kUqhIp8TAzbE6sBdlC4l0ceDJ41+Vk
         qjzAA96UIIHmC0Px2RvBp2WIC7fN8KasIy3JQlIaUwr+5oGv6M7jLiiLRozPICZawtkf
         /43/lvmmuvv7GiyR4eciPdPWQd9nAoNXyB0mJyEQrKUGDO7AwXberiaTztEeY5BSFLrs
         YyZI7+nM1G+dyTJIe5gE7AhBrdg/jUJhAMGmwtpB8Ay4YwRGu5R35euLtpaGZHB8smZt
         7Gdg==
X-Forwarded-Encrypted: i=1; AJvYcCVR9ejN+2iGMKx96qsR541NaNzK7hXDD7lQXtiHeZmrU7tdMymCBTORIAclNkjDZkpRC1Jx35ck@lists.cip-project.org
X-Gm-Message-State: AOJu0Yzo9CpuiL7LVbFqmDGAVirv65VCXZYEaFzbJJaLX3Lee7DH9tGF
	EZWOb4xgZ3V45FDfDV6EJY66nSJEeLe0HcPSRBmcGiqB7T+GYtz87EVRtRQOun2H
X-Gm-Gg: ASbGnctKQraoEHz2AEgnosoLTIcY/QkxomUr3CFTza9+lThvrXkCjRNEsn9w+t5h2Qu
	MqVfBxunW8FdvbG/4YqerrsbVDGhvCzAULt9N7s+xykpNI/whXbz+e3LCM5sgSbsDVb1THpd638
	SxnSTMFCxYfNX/LzRB1d4upEl7tfuxVB77vtfB6KE+USPo18qiNuaRBbmB5uqlWU6h+PUvk0M7k
	5LCxWHdlue5ufgC2nD5khsVwxWc0SbHTQfM66givEd9ju89AIflFR6qIDW9ppqEnc5cSON06oeq
	kdml1TVZEpr0W59MEFxv48PQMGHdRxPXxvcvf9XSMXlz6Rw0k6gETS4S1QrSGDk3cF6loEXQ4Ri
	p7++zTZBoKMagKBywsmZDvaqLWR7mdOj/UuBfIRjwoZ/EdfZRqvQ=
X-Google-Smtp-Source: AGHT+IHuENhHTf6E8Z+FuiRNlT1PtBYuup5ughoLK0Km4Zg6G/ZLmMxp6en9/+WBezO9tZJgqfXJMw==
X-Received: by 2002:a17:902:c405:b0:234:ba37:87ae with SMTP id d9443c01a7336-237d97c89dbmr22895465ad.4.1750391596173;
        Thu, 19 Jun 2025 20:53:16 -0700 (PDT)
Received: from lcwang-Precision-3630-Tower.. (211-23-39-77.hinet-ip.hinet.net. [211.23.39.77])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-237d86ef84fsm6969405ad.216.2025.06.19.20.53.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Jun 2025 20:53:15 -0700 (PDT)
From: lcwang <zaq14760@gmail.com>
X-Google-Original-From: lcwang <lcwang@ieiworld.com>
To: conor@kernel.org
Cc: drm@lists.freedesktop.org,
	devicetree@vger.kernel.org,
	noralf@tronnes.org,
	robh+dt@kernel.org,
	krzk@kernel.org,
	zaq14760@gmail.com,
	onlywig@gmail.com,
	cip-dev@lists.cip-project.org
Subject: Re: [PATCH 3/3] dt-bindings: display: Add MAYQUEEN PIXPAPER e-ink panel
Date: Fri, 20 Jun 2025 11:53:09 +0800
Message-Id: <20250620035310.735055-1-lcwang@ieiworld.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250619-earlobe-skiing-25605816a861@spud>
References: <20250619-earlobe-skiing-25605816a861@spud>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 20 Jun 2025 06:16:34 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19152

From: LiangCheng Wang <zaq14760@gmail.com>

On Thu, Jun 19, 2025 at 16:43:46PM +0100, Conor Dooley wrote:
> > spi-max-frequency:
> >   default: 1000000
> >   description: Maximum SPI clock frequency in Hz.
> 
> Does this actually not have a max?
> The display surely has a maximum supported frequency, which might be
> lowered based on the board it is connected to.

On Wed, Jun 18, 2025 at 08:13:38AM +0200, Krzysztof Kozlowski wrote:
> Don't send multiple patches but version them correctly.
> 
> > title: MAYQUEEN PIXPAPER e-ink display panel
> 
> Don't capitalize all letters. Mayqueen Pixpaper or whatever it is really called.
> 
> > description: |
> 
> Do not need '|' unless you need to preserve formatting.
> 
> > reg:
> >   maxItems: 1
> >   description: SPI chip select number for the device.
> 
> Drop description
> [similarly for spi-max-frequency, reset-gpios, busy-gpios, dc-gpios]
> 
> > additionalProperties: false
> 
> unevaluatedProperties instead

Hi Conor, Krzysztof,

Thanks for your detailed reviews!

To Conor:
Regarding the spi-max-frequency property,
you’re correct that the display has a maximum supported SPI clock frequency.
The provided datasheet for the Pixpaper controller does not explicitly specify this value,
but I’ve tested the panel on the RZ/V2H platform and found 1000000 Hz (1 MHz)
to be the most stable operating frequency.
The current binding’s default of 1 MHz reflects this tested configuration.
To ensure clarity and prevent misconfiguration,
I will update the binding to define a maximum: 1000000 constraint for spi-max-frequency in the YAML schema,
pending further datasheet confirmation

To Krzysztof:
I'll make the following changes to the device tree bindings:
- Update the title to "Mayqueen Pixpaper e-ink display panel".
- Remove the '|' from the description.
- Drop redundant descriptions for reg, spi-max-frequency, reset-gpios, 
  busy-gpios, and dc-gpios.
- Replace `additionalProperties: false` with `unevaluatedProperties: false`.

Best regards,
LiangCheng Wang

