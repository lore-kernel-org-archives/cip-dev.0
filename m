Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.12582.1794488350307257502
 for <cip-dev@lists.cip-project.org>;
 Thu, 12 Nov 2026 04:59:10 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@fairphone.com header.s=fair header.b=eOEOZxNr;
 spf=pass (domain: fairphone.com, ip: 209.85.208.54, mailfrom: luca.weiss@fairphone.com)
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-6b65d69f5c2so965610a12.3
        for <cip-dev@lists.cip-project.org>; Thu, 12 Nov 2026 04:59:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1794488348; x=1795093148; darn=lists.cip-project.org;
        h=to:content-transfer-encoding:content-type:mime-version:message-id
         :date:subject:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=x8S2IibNt/eCRhaNpX4Hwl2UW/5PiemC1oh92m3Qlhw=;
        b=eOEOZxNrJ55cbpT/LHWM6SLbHwON1VfT/mhJqIDX8huRYIp3tVgPGR5QWejpzKygjq
         Xcq6HNm2pGJKoa9KqLfdM1pNQ5mnhX92dxhZP6KFHtnO/IQTwRyQgJOloKWTkscaIxJE
         MqhUt+8C9cGVrFsuT70/pn9vOemGTRnCtwE4XF1Vzobx9exUoivVpIDmJg77jkAgK00+
         HLLwJT3ECjjj6lNLnoi0xDpndcFzhwLNdiDOhm2YfxEjZbcuGq1XRjN9Bx9wYpjUkFM2
         0HMHIt3qitgNDVT/MmwnIU3V8Awnr9KVMgjCbY/WtWO/6hR2hMBfSlyBkBhFS4PjtV7Q
         by1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794488348; x=1795093148;
        h=to:content-transfer-encoding:content-type:mime-version:message-id
         :date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=x8S2IibNt/eCRhaNpX4Hwl2UW/5PiemC1oh92m3Qlhw=;
        b=Cx4y5x/hwOQWX0NGrQbfR+D/EGR3DsnlPvRNYgGGYrLEZa3IBS7h6xHqrxlMQqp72C
         BveZ05zJG6Tk3049wS4BUgrc9g+91tWZzVB7w33Jky/UKnd/ZvUqMkktUa2W294r37jr
         MaXZsuah2CpLVgyHjIbqCgjbmyx08K9dPLgZ00/rT9O3GbXDIu91PYlwpnpukQDOs4vJ
         uJpqAjqpvru83wK52e/q5AxV2azIHY7szpjW2bb5lTHtPCtyW5JoBTvGFRE/hXemfF1j
         VGDLBvrs3cwxANZfgaYsSjPgTcWREOEF9XZEzzIvZ7DFX4G1m2vd4sIqTBUMXH9V7foV
         6M3w==
X-Gm-Message-State: APuU4Z/NvfjilSJ5dosqcd9NGh7MaZgEd4B3+7SMoV4M6mDLmeJqUvcY
	2aUdD9Vjirdbwiu/adJPhhI10Ay1Ia0BNP2EEy3nrDQDStjYeAVhswomkmKm/4acNU+fPpZSML7
	gF+oweqs=
X-Gm-Gg: AYBFou1hSatqBtVIRe0hEt1QEumKDCDAWuo09RO99tC+ul8wJJoTmt9VgbeijKroeKo
	6a4WBjtviaz/ZJueo/adEY/pp49JJWVk1RX99Qs/dWtFDI8EHrKjIlgFRHSar8flKK2a6tvwGnt
	2up+6qLakA8yjok7oMJ/+m3yorfbLRyuyc5JCBB/KWnrjnJnJkPh/Y+bre6i1TnTTDOB1frtLfY
	WM3T2MGoEgQg74lsWSN3JqS8yH8t2m9E6uCs37mvDlpFtO5ZELdsxpYfSUcOCQbZPqxphQ4Pdxh
	l1fekwanBzuaHcm6fpEL5hZ+4wmJDjyllnsSXiHG/BoDETbuh1uNqNelzKlXfDn16E7aG12N0Qu
	95giUqOICZz4KpFXWl6viZFr1tohuMGCXkhExg5pbvDR9+dYtXVyu9qxg/n6J/loq7n22QAxs27
	a3PEk3v1QveK8JxB9MYoT74vSY9njwxvpZ/Rz2GlFY62ezB+X3wbMgWTjpMb4EmIlNiYNktvArP
	zW37xmTgeErVmOB+SBMwabvEKyE5X/i8k9/IfQGwWTmimvDSpa9IFdoknz+7ElRVh3CAy2+tkMN
	cCuFRs4m8seJyv8tc7RJ6qQ6RFb+f4+5j1wobdZIRfDUDPMdE+H+aehnYXt/m4lcuc1MzYbBAFS
	7tQq+1lE=
X-Received: by 2002:a17:907:7ba3:b0:c31:8441:35ff with SMTP id a640c23a62f3a-c5066d19b43mr440250866b.48.1794487852469;
        Thu, 12 Nov 2026 04:50:52 -0800 (PST)
Return-Path: <luca.weiss@fairphone.com>
Received: from [172.16.220.101] (144-178-202-138.static.ef-service.nl. [144.178.202.138])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c504a63f8bbsm336768666b.60.2026.11.12.04.50.52
        for <cip-dev@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 04:50:52 -0800 (PST)
From: Luca Weiss <luca.weiss@fairphone.com>
Subject: [PATCH 4.19.y-cip 0/4] Backport sign-file,extract-cert patches for OpenSSL 4 compatibility
Date: Thu, 12 Nov 2026 13:50:41 +0100
Message-Id: <20261112-openssl4-419cip-v1-0-2f56859669bb@fairphone.com>
MIME-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yWM0QrCMAxFf2Xk2QxTysb8FfHBxnTLkK40U5Sxf
 7fq4+HeczYwKSoGp2aDIk81XVIFOjTA0zWNgnqrDO7oOiJyuGRJZnePngbWjMJdJOf7GDhAtXK
 RqK9f8Qy+paF9Y/3B5b/ZI8zC6zcJ+/4BmUptqn8AAAA=
X-Change-ID: 20261112-openssl4-419cip-ec6f1247fbcb
To: cip-dev@lists.cip-project.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794487851; l=1202;
 i=luca.weiss@fairphone.com; s=20250611; h=from:subject:message-id;
 bh=BaWzRUsclrz0KweiKuTHF6vud8Ip2ylQcfj5RLgUxsA=;
 b=PGaeUqfnOB7HJtpNR5h4TBIcJa77s8jZEGI3WH7cEKz2cLkb086IiYJuyas2ocVT5cl99BNJz
 5AFZIEZSjy7BbBkcUp8iysQfuRvx9h3fjTwYA0KMxl+2sxT3Q8AC55M
X-Developer-Key: i=luca.weiss@fairphone.com; a=ed25519;
 pk=O1aw+AAust5lEmgrNJ1Bs7PTY0fEsJm+mdkjExA69q8=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Tue, 17 Nov 2026 07:57:00 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24814

On Arch Linux the extract-cert tool from 4.19.y-cip doesn't compile
anymore due to OpenSSL 4 upgrade which removed some APIs used in the
host tools.

Backport some patches, taken from linux-6.1.y to fix compilation.

Note, this is the first time I'm sending patches to cip-dev, so I hope
I'm not missing some contribution guidelines.

Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
Jan Stancek (3):
      sign-file,extract-cert: move common SSL helper functions to a header
      sign-file,extract-cert: avoid using deprecated ERR_get_error_line()
      sign-file,extract-cert: use pkcs11 provider for OPENSSL MAJOR >= 3

Nathan Chancellor (1):
      extract-cert: Wrap key_pass with '#ifdef USE_PKCS11_ENGINE'

 MAINTAINERS            |   1 +
 scripts/extract-cert.c | 144 +++++++++++++++++++++++++++----------------------
 scripts/sign-file.c    | 132 +++++++++++++++++++++++----------------------
 scripts/ssl-common.h   |  32 +++++++++++
 4 files changed, 180 insertions(+), 129 deletions(-)
---
base-commit: 596368289cc36e634b7c43a93e9e81b117692845
change-id: 20261112-openssl4-419cip-ec6f1247fbcb

Best regards,
--  
Luca Weiss <luca.weiss@fairphone.com>

