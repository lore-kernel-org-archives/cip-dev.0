Return-Path: <yoshitake.kobayashi@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C691E77188
	for <webhook@archiver.kernel.org>; Mon, 23 Dec 2024 00:25:10 +0000 (UTC)
Received: from mout.web.de (mout.web.de [212.227.15.14])
 by mx.groups.io with SMTP id smtpd.web10.731.1734738834361395463
 for <cip-dev@lists.cip-project.org>;
 Fri, 20 Dec 2024 15:53:54 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: signature did not verify: crypto/rsa: verification error" header.i=jan.kiszka@web.de header.s=s29768273 header.b=QYR8VoE8;
 spf=pass (domain: web.de, ip: 212.227.15.14, mailfrom: jan.kiszka@web.de)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1734738829; x=1735343629; i=jan.kiszka@web.de;
	bh=cib8T44dWplpY5iO38jtDn7+V/VSOZTCrr5uITdY92U=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=QYR8VoE8ChdRiZsiuB2YxFrz4lVu6UAF3ozqOL2Upj6JXkb+EBkG96xQFRD0BvCI
	 RJ6eK8B5NN+ajMCTNgAuUjjXnYVvvkKNuEi3TW6d5DjQ6fZ2LDUzTqsjrwxgdXiQQ
	 9LZxfqa55GoBL4IwECf0p5YtIaPvb0tdMrLbKgpSs+9bcf8TNiW212uOyaXqQIngY
	 2gsLE/ktrFxFCMqmhg9AfRRhL2yGz8raSBnpBRhtoTDF1y7Ahx3W+hkGL3asPFv9c
	 qr6x1pa5VNel1+8VjrV4mfN0LT3qrNZ7WFEljeKGgrT/OrOm5zrtBnimLKE+A7XTb
	 pOV+5zSX2vtor6Kh2g==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.31] ([82.83.18.165]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MAtwr-1tIVIC3FOr-009spd; Sat, 21
 Dec 2024 00:53:49 +0100
Message-ID: <36d0a371-8c51-499e-a7af-ea5a3c1b6255@web.de>
Date: Sat, 21 Dec 2024 00:53:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Issue with the latest commit from master regarding initramfs-hook
To: JohnW <johnxw@amazon.com>, cip-dev@lists.cip-project.org
References: <473d7ab6-eb73-44d8-8611-ea7bb0aa3026@siemens.com>
 <734.1734728634993110433@lists.cip-project.org>
From: Jan Kiszka <jan.kiszka@web.de>
Autocrypt: addr=jan.kiszka@web.de; keydata=
 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
In-Reply-To: <734.1734728634993110433@lists.cip-project.org>
X-Provags-ID: V03:K1:iaahCFUYE+tuIC8HQ20Fa2+HRzyndyTITQ0/1fScpMtDYy6epro
 08fwW7TmTsYmota5T3/nCkA5UI11AnCnh3GKCFhCzfOT3MbPZXb81ncCUA69dXf4fhuliOV
 Tx2xePAqnO1Yfyd0Su5hNhschojR0OvJHPCv+Znj8Lq9G2VlzNu/QWnqwT79Dr2jdeQj7/j
 4C/NH43Xb4D4nNFlvNGRQ==
UI-OutboundReport: notjunk:1;M01:P0:XiE0/OH/OqA=;YSjZccQEGUivze7LbIMYq3TXWDW
 knoR1e5+whJZ1ZCJG3tGgBW3qoue2I9iIWfeWhDy/9umw0fEAOWe2CNocTTJeC3PNJzM6syR1
 D1WOpEVFONOJNIqKWLO5PLam66TglKYp+0a5ekzAKRJM3FQ60f/Sxnq/Ivk9wtLt9conPgO+S
 n0I576Rswcwt2cvz8Oq30fLSrtKaPLSkTv1qMi2jyIoHWtcGCnSAmBgo8Bdg2/XlKEc2XRx21
 48m39428FBmKr2vRDnYp2Fhjpo/flBAlfLSRDKkE4VCjV90WQ2f9eEA9SfULfivloIi5RtXEr
 XslFFTEeIQnYMszhMFcsgiKCUf/+dOT4CyMEVLtjcwJ9F70ssvgFdS2AsaxTUdR1dbrrVgTot
 +n/JmOlFMQz1KJ8wX62l+wApglYQMJfXB+3hTe5MrvoBpcXnqV1UdxB1CcV9ZwubHhxSId6AE
 knl+5mt1+Lr53mg4unU/Q+FTOfmfm/ggTBRHLZ/dOrTSXJ871K+LHBXa+w0KZlBCvlpu8u00o
 n0eAWU/nf/IGt6sxd/K+KsFnmUBouuLRKvKqlv/vW++gxbl0bvmw1DppW2Bz1PDWIs4Y6FTPO
 f2TiB+yq1rt0Z4n2DnBMnfApruXaJq5nViYvVPXMmmVQngLkciFFEwvzAw9lIk6ygoyjHvwnJ
 g97RbsS3JkbyF2uElXEC97Ed0envOj8y7aHUoYX7coloLEuOzralST9tWeFaYZbvr18ARJJcV
 D59F7j4qbhh2EBfGq8WOMhV4T2ZC2iSC125CSTrokznKUdppwoEs/WZ2vms8NDYm01hZIMw1e
 VfMpohUl7yUb3ewzeOWDqaUWmzK00sRT5QygR4LWjU+CZE42KT/1uMZvuVBTu10uVVdAfN+Sn
 yWb90SWTzQDjLar/wqCBAxci+WJ/vUf4se6gfNV7p3Q8LFwuZkdpjDhDH9posmudiYfdaZjAe
 x8fNihOhNdqD4YynUX7yVV0/5QEJS5gWbsA9ws2EEJq2LIP8WuTUUAuE4bD1PWTCYmu16HwDT
 FBMzfiV0nVdhgX3ZUrDUsfWWPKYdc1QxCC30QoXXA4S28MlGTgDdiT2b/RpJauO2k1z4vhkYL
 KHtEwIYx219HhCKYt4Sa/hWvJlh+uA/hKGi58Xzgvjk99MMZ7fVg==
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 23 Dec 2024 00:25:10 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17491

On 20.12.24 22:03, JohnW wrote:
> Hi Quirin,
> =C2=A0
> I just tried to build with a clean start by removing the build directory
> as well as the isar/ and isar-cip-core/ layers that I use in my build.
> =C2=A0
>
>     isar-cip-core:
>     url: https://gitlab.com/cip-project/cip-core/isar-cip-core.git
>     #commit: 75593f244100cc726e7e337298f54f2e80b82a6d
>     branch: master
>
>     isar:
>     url: https://github.com/ilbers/isar.git
>     #commit: a7c4f4040b24dd5414a93ec7beb9e47bfaabca73
>     branch: master
>     layers:
>     meta:
>     meta-isar:
>     =C2=A0
>
> =C2=A0
> I use branch: master for both of them and I ran into the same issue.
> =C2=A0

This doesn't tell use yet which revision you were actually using for
isar. I suspect it was one older than
eae54341ecc46987a5b72b79220ed140304aeca7 which fixed an issue
suspiciously similar to the one you are seeing.

If that is not the reason, please share a simple reproduction case.

Jan


