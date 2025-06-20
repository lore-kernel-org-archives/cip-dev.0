Return-Path: <yoshitake.kobayashi@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3225C7115B
	for <webhook@archiver.kernel.org>; Fri, 20 Jun 2025 06:16:24 +0000 (UTC)
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
 by mx.groups.io with SMTP id smtpd.web11.16.1750391320718195279
 for <cip-dev@lists.cip-project.org>;
 Thu, 19 Jun 2025 20:48:40 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=mpBPJRr0;
 spf=pass (domain: gmail.com, ip: 209.85.214.171, mailfrom: zaq14760@gmail.com)
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-235d6de331fso19214795ad.3
        for <cip-dev@lists.cip-project.org>; Thu, 19 Jun 2025 20:48:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750391320; x=1750996120; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QQes6Cas/O2Il66TXoZhd9SrmsyHWm0zoxLufdtfzV8=;
        b=mpBPJRr0pM+/ePNhEAbNTyUJE7jRGkZiDQkHfHxFarV6hHZmPzrRcLL3RnlTQ+Evmu
         NWuGn7Y30ZFpAyGt+kobbKWqdR4a9RsRElSTHvAyWyluvdGGN85IuNjuGrceAv1/Ac5N
         58kUhI1O6G/2EWcyZSiMU55FgQyAzp9q5ABsiq5LaqpMuFXJniqvapzF6Vf5/dfFhS7W
         g1fjn9d+rI189PJNFl2+4bULcYQSGMo5Va6QOsAW/olspakKLKqQ+VZgAC6Vpr0ri6sk
         EYrDCs4qXWndF159IEbUI6m+f34CxZaW43M7Ik4HDy+sXLn+SJ8wuukSDVHhUySwypgI
         knPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750391320; x=1750996120;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QQes6Cas/O2Il66TXoZhd9SrmsyHWm0zoxLufdtfzV8=;
        b=OHTn5IoB9yuDquA1PDc4a0lYSOsxWpU3djSeck9og/L6V0u57WDI4cv2F8yAAcuB5s
         7F2vqh5pbYNrWivX10Fv7pb8gyMMrkDqucDVc0bdzGLC7/VfRyi7XV7QFsam1MRqGI8G
         eDCkyS3LJ8I51vWp28rQaHYGDZIt6LXs8ylqsC/uIe3I1WJc1znsO0WTdYUQgtn14D7b
         YGRjUSM2TVl94bHSvgko+W7aAVt8V5Zj2Prp5sv3oPQ+H1VbCYG/hdNhSt+9hTIoIpEj
         o28GM56HgEYi52VCKBr4gRF5HpuOBCGfiwvpYIh9wxSS6Y+mHJ5ltmZVQqcHwfVQgz57
         C5ig==
X-Gm-Message-State: AOJu0YzL6PB1G8l6iYPzSgW36QOVuchSzoJLoJ+Ke5UBlABycK7mad2U
	N2gfi9WSghfMfCw3nxGk7gLt7X1EgmKO1GeoeVgwtqkWA18xqc+RWjuq
X-Gm-Gg: ASbGncsWRKmPK6/t8VrBUXUezh9IZgiomOU/kRewddeOTEFkZOFMC0V0F7yqMyOeVes
	5WikptMLRMmHoG11sUFzh1USk4tQpeKZIjDecJA0UAcopDYRTAMA9FFHOe4keG1UivldZwROD3R
	WbpKpDcwWgpM7SeDJiOX3NkJfTS/NSZ5Zs1FbZXe4p70kGIVVw14GYpV78kHZ0YxIRE+L6bxMAj
	DxTR5AXKWrCindMpnnHDeTXHXUXsDHI7aQ0EXiD9LsngAMPA1ar0smTdkqQTZK98di8hR06oSbH
	CARXFop7OtIreroyRcQ3QCXNTLMx/D+W2H9BA2zt4l1Tbq50Ka6dz4ioE3844yhUGx+yHenS5Qf
	HfUWe+B8q3kHxBgJ5u1ff11vzRrXf3aqIWTvt8QaY
X-Google-Smtp-Source: AGHT+IFqygRUTa0qJH/jbI08TI3HUb3mAZh2qKl49pKcYEj8JLf7VIlo3CRV1/wH5tEEYbYFsSXvlg==
X-Received: by 2002:a17:903:22d2:b0:234:d7b2:2abd with SMTP id d9443c01a7336-237d991fa85mr18639095ad.19.1750391320103;
        Thu, 19 Jun 2025 20:48:40 -0700 (PDT)
Received: from lcwang-Precision-3630-Tower.. (211-23-39-77.hinet-ip.hinet.net. [211.23.39.77])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-237d861061dsm6935075ad.118.2025.06.19.20.48.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Jun 2025 20:48:39 -0700 (PDT)
From: lcwang <zaq14760@gmail.com>
X-Google-Original-From: lcwang <lcwang@ieiworld.com>
To: zaq14760@gmail.com,
	Conor Dooley <conor@kernel.org>
Cc: cip-dev@lists.cip-project.org,
	drm@lists.freedesktop.org,
	devicetree@vger.kernel.org,
	noralf@tronnes.org,
	robh+dt@kernel.org,
	krzk@kernel.org,
	onlywig@gmail.com
Subject: Re: [PATCH 3/3] dt-bindings: display: Add MAYQUEEN PIXPAPER e-ink panel
Date: Fri, 20 Jun 2025 11:48:33 +0800
Message-Id: <20250620034834.734926-1-lcwang@ieiworld.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250619-earlobe-skiing-25605816a861@spud>
References: <20250619-earlobe-skiing-25605816a861@spud>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 20 Jun 2025 06:16:24 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19151

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

