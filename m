Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B634CC54E64
	for <webhook@archiver.kernel.org>; Mon, 25 Mar 2024 08:34:30 +0000 (UTC)
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (EUR01-DB5-obe.outbound.protection.outlook.com [40.107.15.53])
 by mx.groups.io with SMTP id smtpd.web10.47027.1711355658712283827
 for <cip-dev@lists.cip-project.org>;
 Mon, 25 Mar 2024 01:34:19 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=V346twCR;
 spf=pass (domain: siemens.com, ip: 40.107.15.53, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P8lf7NDwXl5lLcAJ48scRx/ugIHFeMGIk7IQPlIa+Ots+7cNgJ/W2HrL5Rvr046jPzqKglWKonw5MSEOyQE5Fv618W0+N4lvRiho6E/s/Vi1oMstb/zdPN2Ssct52Rle7H8n/tpXXVlSPjsPUsaiVQ4Iop6472IToT90fWpoB5KK1fwbYVewV3EMF12ZCse/wAOwYsOq5P9fN1xw2/CGS+iV9TJOQMLwvITe9uX0eZlTB31P5nUgdGpoYuT6QdxRT7GGMLnuK747exuVUNtgsfeRTiIIEkgQTwGq/ScFJizYrkR72gz9gTI4Rk8wlEUMsqHMMOelJS3zect+GpdVtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kdY64Xfx54X+8Q/QOmKMYdA85fJrXF5xt4/BIbvaa70=;
 b=hQOEFl446OQ3bC8H1ntMnmalYOC7frmzqPmVSqpErIhBbLPyh/k6r81cKoKrSntfVNAhXO8RbWGDDFuzW6/E0KjPbHQjwJ3NgdwLq1jSPJR4ZwLGbQ7Jygt80wj6goKDfeRylVyccOtwJy1tgM7HgmDlTWjXGdMUCheuYmv6/mJCMDIuiZY3z/srOaxVlB1dE/RqJas7boRzvSRqzQRVwsRt8Ak8+tIysYfHtUQ/JBjuuletJVRtgLRcAi8j2WQHYFrC8P4sslDFLqxS2HZDVDoUelxoJiVCw/qZ1DUEV0Q9VamnXqvw9CYKJZI2wSol2U6nRi1Jco2wIIqrGY47mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kdY64Xfx54X+8Q/QOmKMYdA85fJrXF5xt4/BIbvaa70=;
 b=V346twCRtyqfbP4NyhLcT+VXNmupZG5T22zA5G5SKUhx05t2ljO3vMJDitoxDfUKn6sKBiAPvJud8LB0okZijmEmwBTEd8aerFGVQEwp/uGHAlmPktcfXhxppnxund36/2X/PODN0o28ysrfzxPY3he9k0aqfiC0o6nMHbyYPgIrk2U8XkYIl8MgPOpAzZvOq/Ltoxc+3RDVSEs9fZXWZtkPKQ4KsKQrC2VjHK7dLG9KoQ2mhF94tqfZdw2Kz+BQ0yb1dJYc+MixxG+9Xl+9JHHyQzFu1IllO/53RCCdVpLJSoAN4evSUJaRrcGS5DvFFFq+6KpcUh7XQ5tncGY7iA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1f9::22)
 by AS4PR10MB5696.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:4f3::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.31; Mon, 25 Mar
 2024 08:34:15 +0000
Received: from AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::67a7:ac13:3db4:91cf]) by AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::67a7:ac13:3db4:91cf%7]) with mapi id 15.20.7409.028; Mon, 25 Mar 2024
 08:34:15 +0000
Message-ID: <d7cc79e4-ef20-4d31-befe-229ca3274fb7@siemens.com>
Date: Mon, 25 Mar 2024 09:34:14 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev] [isar-cip-core][RFC 8/8] Add example to encrypt the
 rootfs
Content-Language: en-US, de-DE
To: cip-dev@lists.cip-project.org
References: <c9216a86-403f-4365-9668-c8c0a89445fa@siemens.com>
 <5367.1711067068951668876@lists.cip-project.org>
From: Gylstorff Quirin <quirin.gylstorff@siemens.com>
Autocrypt: addr=quirin.gylstorff@siemens.com; keydata=
 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
 XSdq0hnpafc1V+voPJq3LMxUvLNrwg==
In-Reply-To: <5367.1711067068951668876@lists.cip-project.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0327.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:eb::11) To AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:1f9::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4085:EE_|AS4PR10MB5696:EE_
X-MS-Office365-Filtering-Correlation-Id: d43b10df-931f-4d83-2597-08dc4ca65b00
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	d+JiM1BZte/aCXl8tSsCI9jHO7VHEEGQtOl8GWp/Rw9I8m4tQPiT6Xlvos3wN+sR7BvCPlifeF9LQlgRJQ2zX+Y+qkcJsvLpedGXID2pxU9tIR8c0zbDJpWA5fPghWy2Wr8wjEZpJvkMytEVfSLFBD8KhhWni8PhjxS/eI1cWoMtS3GJGQZuHMOoLh10KZty1G53IxLz0gXTTGQbDpflf92+EviWvm0nXBBO96aJ5NlASMiKN1Xl4XxCV0UE6GxZFTuGNGuaIHmUHJ7l+eaiqpdG2neUgGrZabi3abYWjO4r59YVSb49wmfWqzZ2jAfe4V0rDpMPfb3EDssJsC7YClHPe5gLFN7DPPCz3IzTNzWZ/mzLxY8Kdth28KY0Msw7FFPxja6FRGCfod+dZ87otXoGEXOXNGayRkAm/mqWEGkKplPGoIKwzFq9B1aXuqvgFHBuFKs4Z3MoIxei4r0GxeRnkhxffz8gTfKA7hFpsUYQws8wAg7UJaARBPb2IknWVJcQgEJDdUWOwD5LG+mMoLu//YmqFiU3nPs8/WfD6qnWeUDfnibTMTC3n2V/RCQRC34mWeTIatD32W6xxC73BZaF+tZZCY32kkQqv7hGtoI=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?dVpncFc0RUJjUWxzMWxUb0lXWnlLbEhJUEVUcEFWczI5VHQ2WnFSYzEwRUVK?=
 =?utf-8?B?SFlTZmhPMWppSnZCbzJpVWFQeEQwdG55R3ZzYVNTeDc0LzJ1amN1bmlIQVk0?=
 =?utf-8?B?ekZZL1o0d1Y2ZjlnNjJ0dzZrb2JyckV0U1JvWitCOHUyYjRIeXpaZVFtdWEz?=
 =?utf-8?B?d1p3Q1U0STBoS2Z6bC9LK2M5NUFFQ3BaSU9oV1Y4ejdqMmtOaHZmcWNwSHFG?=
 =?utf-8?B?WmwydW5jbzdqdG5DNlczRjBQbSs3dkRYRnh1RE1LM01DRUkzSXRvc2QyWEZF?=
 =?utf-8?B?anN2S3JFTk1WaWJkUWZFdUhnOWpiQUhpa1VIUFJMNXpibHA4Q2pOby85Ym1X?=
 =?utf-8?B?L05rbFZSdW9ITXY0VnJDb1YzNnhLOVpydWZxRSt6dmZFb25acDdPdlBCYW1Z?=
 =?utf-8?B?TFhadmt4b21nMGZaQko4ZUk2aDlwSGw0RzFuOVFEd0FtUWNGM29YYkFhNnA4?=
 =?utf-8?B?V01YR09DeC9JT29wbFVQOURyT2x2YkFlNzJ1UTJRakNTV00rYmhacGluVnVt?=
 =?utf-8?B?cXA4LzQrK3BHUEJwWWtreDczTGF4VTVhWHNNMHB5UG9wUmFQNURKdG94VVpo?=
 =?utf-8?B?ZnNUNmJCYzdHZFRPelJ4Nkw1Y3JjZ2ZRa2lHUVpVNE0zTkM5c3d0VkZmNXNX?=
 =?utf-8?B?WWJyV1FvRHJJSXFaRFJEZk5Db2pJRTZlcFhxNkhkV05aU3ptd2FWdUdjUHBs?=
 =?utf-8?B?MWZrMGQ3dlVKaHpuNzdIZjd0OEtCaTFkODM0VG54Wlc1SXZ3OEFndktKUktx?=
 =?utf-8?B?SVV2QkFRS2R3M1ZHSDZNRzRHMzU1STB1Zk5NN0luRzhoT1B3aWNjSiswd1Nl?=
 =?utf-8?B?WE5menowZFB6cy9zY1dIaWJFUWNBYU5ycEp0NXVmbmgvNDh2Y3RzVm05VlM3?=
 =?utf-8?B?MlhDU0lOck9hc3lsNStPSzVDTUszQVBKSG1tWmhUMEJjRXNQalBTQTJPbDJX?=
 =?utf-8?B?WFBLc01Ub01iL2FnbHMwTVJLL0FPNTQydVhETFlqNTBCcnA2Umx3QURLMFA5?=
 =?utf-8?B?bm5IOVpjaUFSNmdpdVR0NzJVeXo2a0FUNXFkRGoxeHhIZ3pYSlc3YnhvVVlK?=
 =?utf-8?B?YnkxT0tzTlBCWlBScE1JRmNSbkN4SFdiTTBKSG1TVDlCeW5FN1lHMGUrOUtr?=
 =?utf-8?B?N2ZmdldUcFk1UXR3NGVST05TZ2JZRGdHU2pGbVgxR0hycGQyVnVqRW51TGdL?=
 =?utf-8?B?MUlXOUluZzdBUExIMjVJQTBCaThvZnZYNER4VFpWRFdiWHpJRmRlekpjTFJQ?=
 =?utf-8?B?VWxmSVRESlJJRTJCWE1PeFF2N3p1SjF3R0k5MTc1K0pWRmphZGwxaFpvY2J1?=
 =?utf-8?B?MjZBLzlCSVJhRktmbGxmWVBBdFJJVU1rUVJObWNZck1Vc0hNbFB6ZE1QcWpR?=
 =?utf-8?B?eExOR1ZmWGNsQldNTjNmSi93ZmlzMStPR3hBRXJFUEs0clBud1R1cjgwVnpU?=
 =?utf-8?B?cHJCQmZ4M0p6RFZTaml0R2ViOWhaaHp2UnpHSWpONFdGcFlDMWJCWFAvVkVZ?=
 =?utf-8?B?N3hpNW1FRUlKUlA2bEd4WXVzaUJwZnNUcGZ3d2RqK0ZZZkZvSlZsbjBReUJm?=
 =?utf-8?B?QTdpdDBSUXZUeTY4Z05RMnlqczNEQ1RJWXRHaTA3YkNwcVhSM1gvQmQyd3Z3?=
 =?utf-8?B?SHhhZlZidEp2clRFNXBjSzZtM1pKcGdkSnRHT2VpRjhoMmVRQ0duUDE2MDRE?=
 =?utf-8?B?QTIvNVVqYStodWNSV05mYzB5QWF4YjVkKzBxM2FhTjJPb3RneEVrUFczSlo5?=
 =?utf-8?B?aXNzK1o4SmtwWlBvQm92UmIzNVpzNFBuRUpvUk16bG5yUldzc1UzVkh4VCt4?=
 =?utf-8?B?Szd4dkxQTkhBKzcyUkxtamZiUm5qbmMyeUdkcVYvRVE1N1k5M0s2TXNtUW9T?=
 =?utf-8?B?MDR6bjR0VWtVZ2JzaXFKbnArVkZEcW8zem15czVoRjJ5amdZRlJPQlAwaVdl?=
 =?utf-8?B?Ry9ubkZQUm5WdmdJYzQvNU5iNVFXVTVIU1VhSmNHendWK1VUTDhMN1JQb3BG?=
 =?utf-8?B?bVI2MVZ3aTMrdUpzakNOWGNTeUZDTmlORDdiaUNTbm0vT25tWTFaSDEzMTls?=
 =?utf-8?B?emJFOFJtQ3NIUEc3RVBEUGxoeVpqTDJpUzQ0Qi9XT01weDFVSy96TU5xOTU1?=
 =?utf-8?B?Wis5MjZiWmp4Q1M2SEY3N3lLR0QvN2tMNUFBT0xtWkVhQjlyQ0hlKy9ubHRT?=
 =?utf-8?B?T1E9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d43b10df-931f-4d83-2597-08dc4ca65b00
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2024 08:34:15.5841
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FfJykl0nY+mAW7h71lLXOhd7gPN1UiazHsm0A5p5V1TTTgThFriE9azi3CpYALwE8f6myGMj2V0U9QryEdrXyEsEEAAB1dmFNxX2W2h5n9I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR10MB5696
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 25 Mar 2024 08:34:30 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15412



On 3/22/24 1:24 AM, JohnW via lists.cip-project.org wrote:
> Thanks for sharing the example.
> 
> I'm trying to build the example and test it on my device using an USB as 
> boot media. I am getting Secure Boot Violation error (Invalid signature 
> detected). Is there anything that I have to do to properly set up secure 
> boot? I see that the KAS config automatically include secure boot 
> recipes if encryption is selected.

The Secure boot certificates used by cip-core are the edk2 snakeoils 
keys provided by Debian[1],[2].

This is working for the QEMU targets. For hardware you need to provide
your own secure boot certificates. see [3] for more information.

For testing you can disable secure boot.

[1]: 
https://gitlab.com/cip-project/cip-core/isar-cip-core/-/blob/master/recipes-devtools/secure-boot-secrets/secure-boot-snakeoil_0.1.bb?ref_type=heads

[2]: 
https://salsa.debian.org/qemu-team/edk2/-/blob/debian/debian/PkKek-1-snakeoil.pem?ref_type=heads

[3]: 
https://gitlab.com/cip-project/cip-core/isar-cip-core/-/blob/master/doc/README.secureboot.md?ref_type=heads

> 
> If I disable secure boot from BIOS, I got a "ERROR: Cannot probe 
> watchdog (Unsupported)" error while it tries to boot.

This sounds like your hardware has no watchdog or the watchdog is not 
supported by efibootguard with should not be used in the rfc for root 
file encryption. How did you build the image?

This should build an rootfs without efibootguard and with systemd-boot:

```
kas-container build 
kas-cip.yml:kas/board/qemu-amd64.yml:kas/opt/encrypt_rootfs.yml
```


Quirin

> 
> 
> -=-=-=-=-=-=-=-=-=-=-=-
> Links: You receive all messages sent to this group.
> View/Reply Online (#15395): https://lists.cip-project.org/g/cip-dev/message/15395
> Mute This Topic: https://lists.cip-project.org/mt/105029665/1753640
> Group Owner: cip-dev+owner@lists.cip-project.org
> Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129121/1753640/1405269326/xyzzy [quirin.gylstorff@siemens.com]
> -=-=-=-=-=-=-=-=-=-=-=-
> 

