Return-Path: <ncaidin@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A66B8C47DAF
	for <webhook@archiver.kernel.org>; Mon, 22 Jan 2024 16:48:52 +0000 (UTC)
Received: from mout.web.de (mout.web.de [212.227.15.3])
 by mx.groups.io with SMTP id smtpd.web11.78822.1705940260581904121
 for <cip-dev@lists.cip-project.org>;
 Mon, 22 Jan 2024 08:17:41 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=jan.kiszka@web.de header.s=s29768273 header.b=fOLdW5LR;
 spf=pass (domain: web.de, ip: 212.227.15.3, mailfrom: jan.kiszka@web.de)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1705940258; x=1706545058; i=jan.kiszka@web.de;
	bh=LkIPpB3XuFGyy1CnIn0AsC9pSywVn7whZEPMSigqDXo=;
	h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
	b=fOLdW5LRns6P+Uv5Gk6Dhin0WsXqvWmf+pxTj9MIHV1Ynvu1H9WG8N3xNip4HHkJ
	 05yhig2UxeNiKJXjvNYkzr8Fa8dfLLUmxeYRj2CEt4pacyXtMi7vxEybaadUVd2B4
	 alBs7NEKS4CS76zCXvppaiWJ575HWZgQPDUD3J/1zSJj7xa4tDDjDbasp7/Ibso36
	 NQjybaQ3spTSBkFxgR86ZDzV6rJg/YKXaCGfR42bswT3ZlGImCBHzeaxBvnw0h5ng
	 0gaWeRtzsnhWyVIL1hkEAtbhRxwzobMh4b01qFMSGrO8d7h1HL+XCqBrQM87WDjgW
	 QPSZiqBhN2aWloHJFA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.179.60] ([94.24.63.16]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1N1d7s-1qzKLh3SMy-012257; Mon, 22
 Jan 2024 17:17:37 +0100
Message-ID: <1f0b0841-7cd7-49cc-b600-2fd9b418ac18@web.de>
Date: Mon, 22 Jan 2024 17:17:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev][isar-cip-core][PATCH v2] efibootguard: Fix broken SRCREV to official tag version 0.16-1
To: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>,
 cip-dev@lists.cip-project.org
References: <20240122095210.54158-1-Quirin.Gylstorff@siemens.com>
From: Jan Kiszka <jan.kiszka@web.de>
Autocrypt: addr=jan.kiszka@web.de; keydata=
 xsDhBEq0i8QRBAD2wOxlC9m/8t/vqjm1U9yQCT6OJ2Wbv/qys9DYM0CvcOTDMWQwmV1/VsZj
 KR5YgB5NPt+To7X6x5cjz15AGnx5Fb8Wnrq8EF9ZfHMwb7YMx1LdPYPDnXr37wE3XupFmkHB
 Mes4htyX7Dz8LvKDLnli4IsAmWG+kV1JI6LWKXLpSwCg8JRq4SWoB4VCQxbH3GjntgvwNc8D
 /2q5Dj0urJ7s7sdXhrH0hcFkpSFRmU5Yd6MCwcbFHm2paL5gqVjNNUUwDBKAL9eZaQVIHKwC
 44BvNGO2gcQ26R3AuCHUQ+pZHg34tok1JCNZ6IEZccb+33Qq0qbcDMJJiDYp7ppp6ozifvc4
 YaqJECX48IydxfE9+41oV7T5vNAzA/QL/UMJyTnu5jiOXcyn5iFQw535lXkwKsqeXzCowLho
 HICZ2jITJPdTT/+9pGWwMQqST/SS35Tx4EnS3z2BWsNMCLuXCPkxF1elaMJqMfMJxFD8rAgS
 9GK6zP6fJlsA1wq/UvKSL8v4QPOnTNCVOsyqJVasGV0ZPcDfcj+ClNO4zR5KYW4gS2lzemth
 IDxqYW4ua2lzemthQHdlYi5kZT7CYAQTEQIAIAUCSrSLxAIbIwYLCQgHAwIEFQIIAwQWAgMB
 Ah4BAheAAAoJEIrUrG965ecUhIMAnR6DDCW5cx+cVdYhydbhQXqeief6AJ4p+z4+nrmZLdfU
 7V6nKqKeHeTtj87BTQRKtIvEEAgA2/PlX6oyi7dToH0CJCHq0eKmZaa7CmGaVnxyeepKvIfi
 M8n8Td76AbG64fjREMwgSpb4F/UytF3z/03tj4e49W/zKjbBRB2/wmFRlZBC9crg22Q+bgvM
 OsxnC6uHXaWN8fL+jVei/5OoHOoFqaMsX8EvploitlI/BPj+VgW26jksf3YZyk1hnclsZ/IY
 hXzgRmVJo4RiTW/YLQAkwndwc+fKPa/IYLEDW1Jc4kNLoK0P90b45zju0hpl0C00pVORTOtz
 FK9G5Ha7qOAWJfAVJORHKAkkvwftf3hkpPdLyvZUWRHXvUexmA61fLvDBAFhRxYGD8t5gz88
 SF5Tzq+0ywADBQf/YSkaYrEslPWiCA2wU6EW0yaqBQAobFsOMvsufJ6o2ntq5Ncq37VI3KCT
 67eHPE9x+zPcENoZWsRrC9S9PCf1LOsi7ybZsR13AJqDFlRzJZ4klh9QwgwFZxUBzOdIvttw
 zG1QkzHx06RKZluFYpPF3DRduSMukdIJ2wmWCU+ohB+mYefe65JGjYQfHVs8mgYVFOPxbRea
 9VJACCMuspoZWpj43UdR1lLLyIUFYz+jqcPW7Hd/GTIw4N67pYl0dwPDmFd4ohJ5g4Zpq61t
 oNysBGEuEm5GCcn0VmGtQpSYnR5cVm5b2yPz4bIuFOSuZUo/l7vitdY0iy0/wvKbBC+NK8JJ
 BBgRAgAJBQJKtIvEAhsMAAoJEIrUrG965ecULvAAoKGvxs5T3IhyQT8I8sMsyAvCE4wHAJ46
 S16yab+OxNkvOeoOEX0EnHVHaA==
In-Reply-To: <20240122095210.54158-1-Quirin.Gylstorff@siemens.com>
X-Provags-ID: V03:K1:bMQ1o+k/+g+S+lmkzUQkZa+cEc5GnWotlfF6kYqYt0ly0gE9bSb
 +zI9/6SqynCNnZ+D+x0OwMo1G3TpfSLUnWZfiFVnJtEHP+HAcyC95xGewtqnFm4aM/AButz
 kXLwTM5vtYtBgmls8tbjF08UuxV9So4u/HhllnJnSZAHQ0zjRBU1N+JTdVo1HIFhaORNzs3
 GWw3HtGA1+YLpKPZW4dew==
UI-OutboundReport: notjunk:1;M01:P0:HZeaGQnK8T4=;Yja4YEjzuLM5EFYHbaa1YIxgF0A
 3VxgOk3qeiLH4dGd9KlMp/t5cnjIL9HkcKlJi2p5YeNP6wPIdXPTKi+h98dei4hRtzLX4imYT
 d9LyIUYqM6M2cONO6p1t1u/5WvpCf67PWNPGSrMJvWrY37MgnrVD9p/jp61xHHI4O6qU9baPu
 pciJE+GEDzM4jNOIpbVFeQjR/P/pFrdvXZmzFvbdU/kgL4jji20ulJZj4QZTjd6Yj2jlj0x3/
 9vAKeDBAhPUPlldnfjeJ2byErpPuF3egwNDpJTncmhEKdgVhfnYnyjXAsLOm+UMS1c09aZHBN
 Rx3hr1OPIx4p1Qs8hqWK7zyo4wNickFE3+ZlCj/73Pb9WbehSQcPw7ESBX9MMGyr4oxBBJvVg
 F8BubqAMtsY+cQ66QKSU057F9v5h91tszmjAChHd+jnz19RXDowKDmr767U31h5p1gdw2Hs6N
 N/MwTQqNIhLUprnXwHsBtugMnSdAPGAZBWsB4dolwNI1tEByxmGxh4Y4PEuAvxwfJX9+irRHs
 Z2GCWkF5u/V7niEraknuEzjbI7gmQ93uuo/Ib+5S7pQMOhLEbEeRvZ912WGGGBsVpTgxV2JpH
 vw8yD9W1rS7XGLR+IU/IEZLHfZOSLJxKsXNjJr+1MBFis8NTA6/Vi8O0xg/gAUaKsP769D6wb
 Y7SSK5G0Y/4IKHM2tSdEQsnALQIofuipxxnCOT9XpCqj99M04uaZ+nfLJr5EPDht/PH6hkTI4
 8O8ODH5czvU+GCzi0uJAgh+7/F1SeaCe3T34Vd9CqKoDx7jyXoPg1NIZgKYaFdOpaXfqntf9B
 UWm459L+ZrIn+znGsHZsqdhbTKaYvGT9NbhEd5b9N36gDYadG+K2/6qZzrnKKUXpeAeI8ab9E
 86PLuEb8gECigISP09qhYktTGpM0eTXNIJF8BoxULWpBXxqHhPBo25Z0dRa9f9OvRk97//nK6
 gcmtxw==
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 22 Jan 2024 16:48:52 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14440

On 22.01.24 10:51, Quirin Gylstorff wrote:
> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>
> This is now the tag version of 0.16-1.

This looks completely broken - on Debian side.

>
> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> ---
>  recipes-bsp/efibootguard/efibootguard_0.16-1+cip.bb | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/recipes-bsp/efibootguard/efibootguard_0.16-1+cip.bb b/recip=
es-bsp/efibootguard/efibootguard_0.16-1+cip.bb
> index 93114c3..e9a34d4 100644
> --- a/recipes-bsp/efibootguard/efibootguard_0.16-1+cip.bb
> +++ b/recipes-bsp/efibootguard/efibootguard_0.16-1+cip.bb

We are coming from 0.16-1.

> @@ -22,9 +22,10 @@ SRC_URI =3D " \
>      https://github.com/siemens/efibootguard/archive/refs/tags/v${EBG_VE=
RSION}.tar.gz;downloadfilename=3Defibootguard_${EBG_VERSION}.orig.tar.gz;u=
npack=3D0;name=3Dtarball \
>      git://salsa.debian.org/debian/efibootguard.git;protocol=3Dhttps;bra=
nch=3Dmaster;name=3Ddebian \
>      file://debian-patches/0001-d-control-Make-compatible-with-debian-bu=
ster.patch \
> +    file://debian-patches/0002-d-control-remove-native-from-python3-sht=
ab.patch \

This is isar-cip-core now: We had that patch already in our tree? Looks
like this was once added without ever being used. Also not nice.

>      "
>  SRC_URI[tarball.sha256sum] =3D "d6d37c59aed17489d02b4f0b63db16994dfb8f9=
f70f54be4d65c366f58c6be9d"
> -SRCREV_debian =3D "eacf94e767136a0257850ea0c888d234cb8cace4"
> +SRCREV_debian =3D "ee551bc5239068ce5ab024089cf20385749ae77e"
>

What's going on there on salsa? Can't you (plural) sort out this
questions in an experimental branch first, even if the rest of Debian is
similarly crazy? Even worse, that revision now contains a known-to-break
change that we wanted to avoid in an uploaded release.

And that release looks fishy as well: Date is "Mon, 13 Nov 2023 09:02:04
+0100", but it contains stuff that was only contributed this year?!

IOW: I don't trust this to be stable yet.

Jan


