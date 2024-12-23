Return-Path: <yoshitake.kobayashi@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E9E3E7718B
	for <webhook@archiver.kernel.org>; Mon, 23 Dec 2024 22:52:47 +0000 (UTC)
Received: from mout.web.de (mout.web.de [217.72.192.78])
 by mx.groups.io with SMTP id smtpd.web10.14940.1734966357813431974
 for <cip-dev@lists.cip-project.org>;
 Mon, 23 Dec 2024 07:05:58 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: signature did not verify: crypto/rsa: verification error" header.i=jan.kiszka@web.de header.s=s29768273 header.b=mpg4LaKn;
 spf=pass (domain: web.de, ip: 217.72.192.78, mailfrom: jan.kiszka@web.de)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1734966354; x=1735571154; i=jan.kiszka@web.de;
	bh=o29tpZXm2Uu3Sv57wyDhWEAEWxZ0efGoMBtKpey5VQg=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=mpg4LaKnswDFhzItoFoDXnXWnofjV7lS4OdnH9BvRk4dtLGrLNROzBd5P+1V4il2
	 9Ppz8KHxbiaI/Q9V61jk8WoPN7N6cj2LzHa/6LUaWcEHHCIzk1pcpfUayZvhIKdpe
	 JItlGISlzuuxKQjibkHf930eSKVQapZy9dc0s7MEGet4jrDRYFJrc5XllBdzYuS7s
	 rLVE+aCLM4C0tGJkhxkRu5YmNld7YyICpjnU/R8OlnLDuoMn4v08sz9eBUERUVqc/
	 w4S9GI6cuMm011TJFqi5agb0tqLRDNpL1t8VjqTJNlPyks0KCw5xlBEKrnDwPZm+H
	 zQ2EkRaMTIfwW/9ERw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.31] ([82.83.18.165]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1M2xrq-1tOd0o1VRE-003JiV; Mon, 23
 Dec 2024 16:05:54 +0100
Message-ID: <3a577e36-3b0c-48cf-b628-9234e2cbe48a@web.de>
Date: Mon, 23 Dec 2024 16:05:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Efibootguard & empty fstab in initramfs
To: Stephen Ecker <stephenecker240@gmail.com>, cip-dev@lists.cip-project.org
References: <CAK9C7GBFw=nN8mZWB_aC00QFYDxF19-4__1RPf_5kbKyuNmrPA@mail.gmail.com>
From: Jan Kiszka <jan.kiszka@web.de>
Autocrypt: addr=jan.kiszka@web.de; keydata=
 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
In-Reply-To: <CAK9C7GBFw=nN8mZWB_aC00QFYDxF19-4__1RPf_5kbKyuNmrPA@mail.gmail.com>
X-Provags-ID: V03:K1:UwV/p7pr6R9iwHCujQEWkKY62Nyfajx+keLTL7xDkaLlHrSsxCq
 xlT7TTRcfivM2mspH9BCH64RhZuTvGeXug9Lj2SrmY01kcGiNuPxzAn1aM1lFehnumPbV/8
 U5PBmLshcPSy9KtHaRmzaeWeYaea3oVzlMQyyImTcwOBJQZ53xHQ2HExbtZxMNbX9pl7mZ/
 +67s9qENCHPmIt9blr6HA==
UI-OutboundReport: notjunk:1;M01:P0:Gt9mniFvhDA=;kMGueRWZ7ak/GuUZARGgMZeCmaP
 P9UcJrnTf8VR9EZ99w3RSRfbERRgpb70ZJwe+/t1WzoAClh6bcPsS94wIufxDxDGHuqQpQaFg
 DuTEZFdPYyXiAn02IVee36xKn968GOlUUlGWKrZfRrHQgYhDdO3Qsdj71kkFrtmALhcaYJwI1
 pfrk3wQr2nJZl9+hXdFL6OdEFL9Ae8SYOx/UBq1DH8C3K4sBT+rwy1WCvFqjwV1+z0QrjhNUX
 1clqzwc5t3bw3sOOsFUYuyaomIsP3dvIzQgyT21TjuaF4tLJGQgyE30dDtrh9nJNP8DScJVGl
 iW3lIab2SYwGUvXX9zcPZiy6WhxgDCMBryS7pIZg7zV1NPM3b17YEcKyfElG+76OKe/e2+29R
 Ox3UL4ph4RJ+YLSpuemQuEMeVZzqXhMz5hbEPg3/WfNXfIck72Brzrg7MgoR7OWXSeiie/1l+
 tm+6nmh7MV+tDzC70yMWtxQaZmXE9EIB6Uzt5JOzb14TbMOqrITzhz38vrgOhReCxdkCQpZRK
 GVQ2p6dyCan8iXk/+y5ErqGT9vbYsv/nzB3UtS2DnlXKQM/7024RiYOYr8RFyWoBlVA7vHzTF
 Yr7n0HYdWJwO340AyLB/NFVv8Ln8ycjJmcSbtyctRR8gH2FeS0wdHNkU1ChNnrWk3cRqX/KJC
 rmD1+9T76fM+qiu15aYPSL0ePxxeH/19OOncix+b8wYTnXuzjOzpN4OV0/9IVK//Eo10hoAwC
 LqJc7RIM3uKTykp4q3zbTGx2Lpn7Qn6HyFP0ZiSZXYR6A/zenxNvKeWBGX68FVKDDLpztZVaj
 OLcvF35yZJxvSBj7yi36gkP0VeRBQEqjlHJ5kRKc0kR9v6d1tkIcpQUk71Wjh5QsKbN5d8ilE
 DjTyJoKYJu4yGf84r00GmSTkpUwivg+yvXkxzf4Wc6BxOsINdxrsiJcbcqnOA10j+/obQhatm
 nWcwjfCiscXe7rbZ3YYBdu0l4abdHdMQqE3jORv3EgR6SlZJ85/4O/ZB+gQK53M8v0A9NMUal
 KsZs1yU+D05ffJQZiDALFVOhTy1VIifqygST7hr2YPJ7zp7jdRfOtWaIPH58O3Y3ANYsFwgMO
 CiADQQiI0=
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 23 Dec 2024 22:52:47 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17492

On 21.12.24 00:50, Stephen Ecker wrote:
> Hello, I am using efibootguard with the swupdate recipes and the image
> cannot boot as the fstab is empty.=C2=A0 Any ideas on where to look rega=
rding
> how the initramfs is created, for debugging this issue?=C2=A0

How are you generating your image? What is the difference to a reference
image generated by isar-cip-core?

Jan


