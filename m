Return-Path: <kazuhiro3.hayashi@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EDB7C4332F
	for <webhook@archiver.kernel.org>; Wed, 24 Nov 2021 12:02:14 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.158])
 by mx.groups.io with SMTP id smtpd.web12.5295.1637755331996063193
 for <cip-dev@lists.cip-project.org>;
 Wed, 24 Nov 2021 04:02:13 -0800
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: toshiba.co.jp, ip: 210.130.202.158, mailfrom: kazuhiro3.hayashi@toshiba.co.jp)
Received: by mo-csw.securemx.jp (mx-mo-csw1116) id 1AOC28nL005382;
 Wed, 24 Nov 2021 21:02:09 +0900
X-Iguazu-Qid: 2wGr0wVJrxDd3wflrs
X-Iguazu-QSIG: v=2; s=0; t=1637755328; q=2wGr0wVJrxDd3wflrs;
 m=l5YDGBtr/+DpBUjZb1FYxaGaUAFApwPlM+51M/qw6zw=
Received: from imx12-a.toshiba.co.jp (imx12-a.toshiba.co.jp [61.202.160.135])
	by relay.securemx.jp (mx-mr1111) id 1AOC27mZ027639
	(version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Wed, 24 Nov 2021 21:02:08 +0900
Received: from enc02.toshiba.co.jp (enc02.toshiba.co.jp [61.202.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by imx12-a.toshiba.co.jp (Postfix) with ESMTPS id 4FE131000D7;
	Wed, 24 Nov 2021 21:02:07 +0900 (JST)
Received: from hop101.toshiba.co.jp ([133.199.85.107])
	by enc02.toshiba.co.jp  with ESMTP id 1AOC26xD012362;
	Wed, 24 Nov 2021 21:02:07 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NMO7s49Sfm6ExBGhHr8/y7iz4e7iDM2RrL0sW9xd9Ld34VRKnH9rLAXM/vFjtNOtAq0me+FARqD548D5+y3BLPS1fSuUVphwDbH6J2QyQauovuXrC1Dt3jkzXZRFN2/72xsijCLN/t8E4k/EE/X6gbEfVDsE3irjvs9bEZ0FBIAWHrsXOBVOcitroga3+3tGXQ5OCef8UJNHFy6N/zK7nTo5tGRJJqEK84CUNsyO1V1rRmMmZ+S/Pzk55RZ/ASb1FwSNYOEjwTMddLCQQsbP6I0weE4JT3x3W3fXXUuHhCr/wrcZ9MzUXDPRF441yUxCjLCQKMFSMpnjO8QehtxQvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9Va4eDVioEOGIyDUwPmPMgEEYlWIuo5RxeH85lPnsHg=;
 b=KpE3ObWp3+5YGW/UQ3gN/y2m8UzKsrRt6Irx4KGL90PAqsl+0nsDNFgvNyi/LtgcYfZwMEOgF2Y6n3ZOo6pGuCTj2ClIkAn76+uZFi5GQvcCBWwK3c0e3j0AmxfQExqlBS4FcxI18QimsSBenOyv5eAb+NWwJPZVnH0dttp9k1DKymkQcW+cINTv/GY89N/Z/cM8pDzbMnbLTjaA/+4PlGU7Cr2rLiFEaN+ahhXIwLg8ktdbmAbdCqGHyLETn7q338OdoEcqjnr4F6TLN1MT7dLyeMsGjMh5MKeBegetNCTEKIll6NKSsNYk+Tm1N6Fkj+j9+FCQcJzCSGLfu2/HPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: <kazuhiro3.hayashi@toshiba.co.jp>
To: <jan.kiszka@siemens.com>, <quirin.gylstorff@siemens.com>
CC: <cip-dev@lists.cip-project.org>
Subject: Replacing BBB kernel config: Status and AIs
Thread-Topic: Replacing BBB kernel config: Status and AIs
Thread-Index: AdfhKw+c+9rAP2YhT6mWMn+3wpW1ew==
Date: Wed, 24 Nov 2021 12:02:05 +0000
X-TSB-HOP: ON
Message-ID: 
 <TYCPR01MB84234CF202EC19BCBE72D233E1619@TYCPR01MB8423.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8da71f5e-43ba-4d36-df46-08d9af423b95
x-ms-traffictypediagnostic: TYCPR01MB8112:
x-microsoft-antispam-prvs: 
 <TYCPR01MB8112B9FEEBA27AD628C551C8E1619@TYCPR01MB8112.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 4OhSnwfYGkGmDnDXxx6eXUikxQoj1hMzG5QzMGgMRqxggE2eHFfgqIDMwq061KJIV82wRoijcUO5E3Dox3hex/tDfHHIa0ALCok1dEc6pwefT+3DK311aN0XFH5a+dpciN4vt4s31dQBcIQ0n72ht1PTZvQmyFCS7UAnPCBpgeM5MJO/hf/fqsRZ4OEAudX/ppMGvYze6MwCoB69bu2hN3Ew98JoXqxVklrl/eBWFvBV838B67iFV61VFRdBPecaTmkW9qyp2eshXA5ojFYBiTPw+ytk5dGPt+U/dUsYt6L/rNLXHCF3sUWKCVzEJn0lqFWGhnc4OCG1hIo77/N0SlvVQEx/K5h51KJYCT6q8dabPr4UZPvEzW5oDanllcAtHBYFbgb4AWqfunwSdVl8PJVJo/rts49VigtBkUDXWelzf42bi7oNgjsoip5TP1qtiQtQPA/cJ/w6Lu975CNj23V6AfiGEF5OLBK0jRQYVz13oxml55Mn7RQySDTzIHik2ljZ8CqR32EEfs5D0pwTWBVUtD7Ue7b1XLC0fx47W/YCvVDcXz04cxIhq2Lff2awtirU7Dw5jMT42OKTg0Tr0kDJUQ2R37HutwPGXEn4Tq3ZW6T89CQps1micBvjKrCph/bVbfRp5EVfIJAI+4uAo5V7bad2PdJ/O/P7bBnq2AFVbhBCEANltXeJDqmLZYcPo3p29cDlUEciay0ZhiqvXywcb/93MW9CtAbexo8wYiK7BAHDsIxdrfxIQ4gehFbEh0NPIgpJGE9aum4ufkWnRpdmjnwySlQcR/cvcPpdgAU9anm571Da6Bxx8mFdsJIX
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB8423.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(4326008)(83380400001)(71200400001)(8676002)(26005)(52536014)(55016003)(7696005)(4744005)(316002)(38070700005)(110136005)(66446008)(66946007)(186003)(8936002)(9686003)(76116006)(38100700002)(66556008)(66476007)(508600001)(6506007)(5660300002)(64756008)(122000001)(966005)(86362001)(33656002)(2906002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?eTJJMk51QXdycXppdElEcGUreWtnRlRHaVZLajI1K1FrTFpsd2N1NGlr?=
 =?iso-2022-jp?B?TUVCT015RVNRdE5hTVRXdlhXZFhOSmx2NDdBRmtOejhqcVZucjJZY3Nv?=
 =?iso-2022-jp?B?L2JhZ3hkejNSWHBsNTBsRCt6b1FYaC90bWsyUUVnUkJXQkJUNXgzRUVx?=
 =?iso-2022-jp?B?azhTK2J6RERWZVNtNG9GOTQrdUc2Z3BraGRxQ1ZPNjZlaWJMWGgvRjNH?=
 =?iso-2022-jp?B?eml2cTVRd3AzK1M0RlJvU2Nnbml1K0ZUaTBZV29NWVMxL1BpRml1eENV?=
 =?iso-2022-jp?B?N082T3U3VjA5V3Q1RzJsdEVrZVJMUzdjbktwSnc3U3JJckxpRFU3QlZJ?=
 =?iso-2022-jp?B?bjlycWl6SjE4eW9LYW1ya0F5a3hxbjhtU1AwWXNOeGJtc1N5SDl2a1ov?=
 =?iso-2022-jp?B?L2R1UXhIcndTb09BQnc5YW1wMm1mYkJ6dVkyVnQ2TVJ5cmVWa21aMFFD?=
 =?iso-2022-jp?B?dXlkRlNFa2lxQlYvSVJBRXhBREQ3UGxxenF1TkZVYTdQdzlPeXFWUm9J?=
 =?iso-2022-jp?B?Rzg2UEdJODdmRU9CeWtGMUpETVJ3eVJGQnFuRzBCZUFEYjV5UzBteXIz?=
 =?iso-2022-jp?B?OWdkRVZ3N3JBMkZwZTRIdWpRU1dZZlYrbTlCMm5lOUZxUGFURkVtSWxj?=
 =?iso-2022-jp?B?QkxSUS9uVzBXR2IrZkRGeFRGcG41M084VjA0dm9kcW1NYnV0OTJKeEZy?=
 =?iso-2022-jp?B?NlpnS3p1MFBpalREdUoraGNaR21NOXdtNGNDOEswbiswMUROYkdvdHdJ?=
 =?iso-2022-jp?B?MjZxSjBoTEQxdnkwN2lLYVNmVDk4N0hNeXJKb1dBU3RNc3BGYjVUalJt?=
 =?iso-2022-jp?B?Z0k4b2VWWDFJMnJ4ZkZNeGdsdXdoTW4rVmVoRFFoSmUzR2k4N3J4Ymdp?=
 =?iso-2022-jp?B?QjNsZlVma0IxWGk0NW1yRlhhaWd5TEJNMHV6bjV3dDNBUmx2RVRwckxR?=
 =?iso-2022-jp?B?Zk0rTHI5emFzZlVwVy9VOHZxcFduUVQrL05wQmtzY1hTWmhkUGRnZ0c1?=
 =?iso-2022-jp?B?dEdsTGdWclR2ckRINFpJdjhObTVWbDFKdFEyZXhDbmpwTVBVUUVYYklP?=
 =?iso-2022-jp?B?SXNScnlNS0hqeFJWTW1oLzcyeHhyb3B1djU0Ynh4QnNtOWY5TmUzQWJ0?=
 =?iso-2022-jp?B?bVZsejZqaEk4VmRJbWdidGt6S3M5Q1ovV1RPZTNiNTAyT3VuQ2xvczNt?=
 =?iso-2022-jp?B?TE5BMHNqWE5OZzRnejVXVTEvdCtiSndLd2lBWnFvcU9TVENGSEdZdEhq?=
 =?iso-2022-jp?B?YWVhcGVUSElpYm5jUmtVVm1LQ0ZWRFhpQ0pPbHp3akpleDRFWW8xN2dy?=
 =?iso-2022-jp?B?V1QwVnc3ZEZUWXFZSk0veWhaSkROMmF4bEJISk8yanlqTTBaT2p4SE1J?=
 =?iso-2022-jp?B?eU4waGZSSDA2Q1FGNUdtMGFQR0RvWExtd1I0bGVEN3NBWW1odzl0bXNM?=
 =?iso-2022-jp?B?M2p0Wk5hZVBFRjNPcmdVczFPR1BLQWdQRmxHeVN6bW9WdEsvNUVrdG5l?=
 =?iso-2022-jp?B?cUdGcnQ2UldYRTN5MjcwM3Y0ZG9LU1BMVGM5MWFxZ3VJOTZxcVdKMlpl?=
 =?iso-2022-jp?B?dFBrNGRIRHdwRnQ4cG5uZ2VSSUlOem9CUHBUZXBaeUF6VjBPemtzMkdS?=
 =?iso-2022-jp?B?SHFLcXFhQ1ViK1NtYktwcFlXaGtiUkg1YkJMQzI3TTlFcTQ2SzNQVmpQ?=
 =?iso-2022-jp?B?OFZSS0xKOFc2bU1FQmp5NVpaNHAwK09UdGZYUXMxKzUxUkI3d3JmeHBD?=
 =?iso-2022-jp?B?YmR4N1VsNzZwQnc0b3UwR3N6V2JHeFc4a1JicnRXalAvUzVvbXU1QW1S?=
 =?iso-2022-jp?B?UG54STJjRGJ6OFBkS09YalVPK2FVQkhWcTRxb1VoQ3A2OU1wOVFaZDJW?=
 =?iso-2022-jp?B?SFhkKzlyaFdMdTkxeG9jZWNlZjdKMExiNGJYRWxwNVVCaXc4QUQ4aDk1?=
 =?iso-2022-jp?B?a0twNFU4bGdsVS81KzI2Sll6K3RQZUJtRTdkTzBLZ3V1S3FndlFqejZD?=
 =?iso-2022-jp?B?UlFDVmljbnhDZ09kV0RKemFnbkFBdkoxNHlzK0xJWktoaUFWZHg0cGcv?=
 =?iso-2022-jp?B?QXU1bGpodEErTFBOdjJyL1RsTFFMeVdWZldKNEVlOFhvY1J6bEZqby82?=
 =?iso-2022-jp?B?QmZEcTJ5OWNkaGlkSVlaWkFvUXRGSWx0YjJKSFZhNk53OGhiaVprYnY2?=
 =?iso-2022-jp?B?ZjBTcklta05VQkkyaFpIbFdiSGk0eHE2T1ptMnZsdFo2WHFxMjJobnN2?=
 =?iso-2022-jp?B?V0J2c0NYR2I3ZWQzbkVMNHlMcExsdDZ3cDUrTFR4UHpGS2FyK1dSYXVH?=
 =?iso-2022-jp?B?UUFEK1YveWs0MmZSWGJRc3RreGdSc0J3bEZRWlNxeVZQVmQ5dVNYWjdY?=
 =?iso-2022-jp?B?dFpYMnZJRXgyUjIwRXY4M09EVkxYc1BVeTJvRTV3dVBEQm9MQUQ4eDV2?=
 =?iso-2022-jp?B?dE5PSXh3PT0=?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB8423.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 8da71f5e-43ba-4d36-df46-08d9af423b95
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Nov 2021 12:02:05.0880
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 
 2Ai9C0cSnjLWvnzGz+BUZx4YjukudOKvr8N4OVyMgnVaAHLqGzBdBqpQUyRWQheHy0dfp6ieej8gCWvjj7GU3sHqwANvEjHWrgastiOHCl8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB8112
MSSCP.TransferMailToMossAgent: 103
X-OriginatorOrg: toshiba.co.jp
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 24 Nov 2021 12:02:14 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/6994

Hello Jan, Quirin,

In CIP Core meeting today, we tried to discuss the current status of the ac=
tivity[0]
to replace the kernel config for BBB in isar-cip-core (bbb_defconfig)
by cip-kernel-configs (cip_bbb_defconfig), but there was no enough time to =
conclude this.

Questions:
Do you have any plan to create the patch v2[1] to add some configs to cip_b=
bb_defconfig (for both 4.4 and 4.19?)
If yes, is the next step to create the patch v2 then test swupdate with 4.4=
 and 4.19 kernel on BBB?

You can find the meeting note[2] related to this topic.

[0] https://lore.kernel.org/cip-dev/f8f989ef-7ee2-42ee-a922-f53c6d2b07fe@si=
emens.com/T/#m864738e612f98752d216bc976135c274fd73eaa4
[1] https://lore.kernel.org/cip-dev/f8f989ef-7ee2-42ee-a922-f53c6d2b07fe@si=
emens.com/T/#m4b75aee175603bd1f06a8eec2b47ac08bda85c5a
[2] https://docs.google.com/document/d/1MwHdFd6QuXcdQfxvaLkcm1sqo9zEC-CWxjo=
f8OJFXLM/edit#heading=3Dh.e88ar5knf3z8

Best regards,
Kazu


