Return-Path: <iwamatsu@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3049D59F58
	for <webhook@archiver.kernel.org>; Fri, 12 Dec 2025 23:06:27 +0000 (UTC)
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.840.1765580783712583986
 for <cip-dev@lists.cip-project.org>;
 Fri, 12 Dec 2025 15:06:23 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=A1jukVeS;
 spf=pass (domain: gmail.com, ip: 209.85.160.182, mailfrom: iwamatsu@gmail.com)
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-4f1aecac2c9so18941001cf.1
        for <cip-dev@lists.cip-project.org>; Fri, 12 Dec 2025 15:06:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765580783; x=1766185583; darn=lists.cip-project.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t10ITyI4woXUV3Ue3kFTTbG6hGodrRUsSYxvmIl4ogk=;
        b=A1jukVeSeY+hxO8o/YmQw9Kd4Iqux5Zgj+vg5lBEEwzrHUbVIhlqHhxKkWaSbYAhOu
         QiKXxDc//dUGeD9oOAwMtFlUtUU6Ft0eZp0RTY82WreuYWZ9JnZI1TGc6ab++EjEB0E4
         WMLdQ23ozr4lH+yru4I4B1bJGfh8qLuNE/jQpVSYgpcXD0+LRXIVmwU2cArepEBU6m3X
         jI1gViTzmL8E1TLaIz5o18nwyAPph0O+rYPHiF3PYI6nn3z2il4LEE9UV6D6OZ2z/ROX
         zpFwDfdNzTiSIZRIsRcSf7drmlywB1G4Br62rpqsHa6Xv5tZwBXW83wf84e0utMjp0si
         z9FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765580783; x=1766185583;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=t10ITyI4woXUV3Ue3kFTTbG6hGodrRUsSYxvmIl4ogk=;
        b=Vmx9iNV7YRdPw9U+A8riJ3JNDLLWo/12atud4DSTXcA1QGTYxF89xqhJt5kxtUozh1
         uYdoKNAzNAGFV8ltjU2IwaILXl4cnlfakK93/Zb90foCjUAgBNGHqvYxcUVYBY+lbkYP
         drf6Dedxgkn2QZBkE5xMAZGaeTT5Gl8zD3UrE9jm9/uUtnB3lBhr7dZzcUIXG3Aifoph
         L1Jd+0snK0O95L5X3yuQXXK8KcBHO1sHDmQ+5Obj/Hz6LNj/ArtybQGXBctj1cOx06et
         Ji7QT4xoX1ZxBZ6m7rpCbxre/Q/WwBnduUV9sceS7TeqVhtwaoUm0ljWvOQWp+29qPVU
         9eHA==
X-Forwarded-Encrypted: i=1; AJvYcCVUhd0KcPcV1d6FDVEB+5n9jTNV5MVFYBiNkT3fJmtJx9Ofzo4c1OnD62zLblVk3L/q6FTqE2Du@lists.cip-project.org
X-Gm-Message-State: AOJu0Yzqh2JTurtS+OH84amgF5JVfcmkWi9FKk26ArjrOABqIS+KZl6T
	AIzO+hs4gPAnYH5DXU87BgzR/Y1SZWE0YWaPo08zZS/491rjiVS2PBIK9YWJtl6lPd2K/XZ+hnp
	F8PlJ6nSlyUip79zymawmV0HKDELL2K7DI6llOTk=
X-Gm-Gg: AY/fxX4G9EW900ho8lDXR9Hr3ZM0N9/gSEwo+pe4WxJYp9yLRactEtd0oTvdKRoeaHg
	RgJYP5O3FCJOC80WoosspNayhbCv1SNLfLU7K+UaPr3EOaK927O7sR0zSfzbyj5+J+ZUZ/VZYz6
	FYO2sqW2DaXE4+2kQjFGd5PrMduJOaJx2dIbTImqMy8K6KQv9C4XTKLssYa1mF9illOjwOc3Q06
	UMWs1sjz9aZCq18faZDsy32u7Q3C3Pl8Fhm/dEFSpSqjlo557lcQyfQd0L1oPGEimPy
X-Google-Smtp-Source: AGHT+IGgyA1nVGeVAcr/fR6kRR2QfbArMHv4kC11EgMZVFoiJSzvreyUAPQo4Dl1X5h/8Om4JoHznBWagVpXQ5zRks0=
X-Received: by 2002:ac8:7f08:0:b0:4ed:bc0a:88c3 with SMTP id
 d75a77b69052e-4f1cf5f9fedmr57639641cf.33.1765580782700; Fri, 12 Dec 2025
 15:06:22 -0800 (PST)
MIME-Version: 1.0
References: <20251212091959.22073-1-ovidiu.panait.rb@renesas.com> <aTwHsY50UE33lrbh@duo.ucw.cz>
In-Reply-To: <aTwHsY50UE33lrbh@duo.ucw.cz>
From: "Nobuhiro Iwamatsu (Toshiba)" <iwamatsu@gmail.com>
Date: Sat, 13 Dec 2025 08:06:11 +0900
X-Gm-Features: AQt7F2qVptGcGzu3QlGRDboG6rRXWIRJeecSeQL_F9LhTJUGSUb1-vTkf4mje58
Message-ID: <CACe6DC6xHW2UEHXJyFkAWwDz=k_zr0yHce3CGD6eD7GLwkeo7Q@mail.gmail.com>
Subject: Re: [cip-dev] [PATCH 6.12.y-cip 0/5] Add RZ/V2N General Timer (GTM) support
To: pavel@denx.de
Cc: Ovidiu Panait <ovidiu.panait.rb@renesas.com>, cip-dev@lists.cip-project.org, 
	nobuhiro.iwamatsu.x90@mail.toshiba
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 12 Dec 2025 23:06:27 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21006

Hi,

2025=E5=B9=B412=E6=9C=8812=E6=97=A5(=E9=87=91) 21:17 Pavel Machek via lists=
.cip-project.org
<pavel=3Ddenx.de@lists.cip-project.org>:
>
> Hi!
>
> > This series adds General Timer (GTM) support for the Renesas RZ/V2N SoC=
.
> >
> > Patches were cherry-picked from mainline kernel.
>
> This looks okay to me, I can apply it if it passes testing and there
> are no other comments.

Thanks for your review.
I reviewed this series, LGTM. I will apply this with Pavel's reviewed-by ta=
g.

>
> Best regards,
>                                                                 Pavel

Best regards,
  Nobuhiro
--=20
Nobuhiro Iwamatsu

