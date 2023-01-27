Return-Path: <Shivanand.Kunijadar@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB599C38142
	for <webhook@archiver.kernel.org>; Fri, 27 Jan 2023 07:19:48 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.158])
 by mx.groups.io with SMTP id smtpd.web11.97238.1674803984673164240
 for <cip-dev@lists.cip-project.org>;
 Thu, 26 Jan 2023 23:19:45 -0800
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.158, mailfrom: shivanand.kunijadar@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1116) id 30R7JgCB019944; Fri, 27 Jan 2023 16:19:42 +0900
X-Iguazu-Qid: 2wGrC6bcqEDcsSnjzQ
X-Iguazu-QSIG: v=2; s=0; t=1674803981; q=2wGrC6bcqEDcsSnjzQ; m=B5XEl6hwOaIH+XwkUa4o2n3jLHEAEB+EyZVmar2IzKI=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1113) id 30R7JelH019864
	(version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Fri, 27 Jan 2023 16:19:41 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HPDMqPE/Xow9Yu3paBjQH6roZVhfpwlJDIO5vD++rTRwyluA7+L+ju+vhcAHXDVhkYGSL5v9oiukSO9654mtgMAYK92k+lSkYkSMd/MF9QSFIw8vPXi770UyFu0vFSqPcUQuKENL230Le93KwedIgEF2lDlRGLflh0/CNiYkmqyM/bZ61cwwOv+0Ci+9gY9RRhpzeD1LuBz8xMTxmmRnT5PC5HqizLnr+T/PEvP6CHqTDIDxa/6zKoYQ3JuYV2tKHDrm4qk5NtJBLBt9sofqF4CG/tX+JgO2WBKRFs+NHegYlkc2Bo8immOywKlZJ/jQDbQRLLHiN9DiNjcR1xW4Hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4IcGrStmaOPxqlHgAIIFcJfwloPhCd86LoWWtZJiMXs=;
 b=D9sgReSLBCUJ0z1fjVmZAOkMUQ/ARWZobdJ8dR3dEaYYRMukvU3OEUiIBrNu696XL+En67z5p231rogAd+0psN9HqcElDNQaYkcn4VYmtJEk25mLng7L1wP+GhVcJ7o6cSxn9ndleI55CmaQpubGQbVbtYbZmGhf6ajuOcjG/wifLJQAtrUzNO5SNjRtNt7z4++axJlNc2ujW+gLkb7O6qmMar7+irA7HbUH4iFdkwV1JAJEKeHwkdFEY6JnP/8B+g7tJqr68NCpMDEWQAYUTZtx0G+biWxEblL9ACRNMu+V6ooPlFd5gOfSBZM6dQ5YIeIF559tuYqYQr/SB4OKGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba-tsip.com; dmarc=pass action=none
 header.from=toshiba-tsip.com; dkim=pass header.d=toshiba-tsip.com; arc=none
From: <Shivanand.Kunijadar@toshiba-tsip.com>
To: <cip-dev@lists.cip-project.org>
CC: <jan.kiszka@siemens.com>, <kazuhiro3.hayashi@toshiba.co.jp>,
        <dinesh.kumar@toshiba-tsip.com>, <Venkata.Pyla@toshiba-tsip.com>
Subject: SWUpdate with unified-kernel using UUID in the kernel command line
Thread-Topic: SWUpdate with unified-kernel using UUID in the kernel command
 line
Thread-Index: AdkyGi2hbFoAUaDFTTO9C3khO1D1ow==
Date: Fri, 27 Jan 2023 07:19:34 +0000
X-TSB-HOP2: ON
Message-ID: <OS0PR01MB61478EAC2D405DBD1F486152C7CC9@OS0PR01MB6147.jpnprd01.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba-tsip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB6147:EE_|OSZPR01MB8735:EE_
x-ms-office365-filtering-correlation-id: e4319383-54b2-4be6-b69f-08db0036d7a0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 86zCIgVGwO0Y1KWX8RY3OAyi4VYjdHMX7RklecX2RZZCgFb4YYFYzWDef0PYdsSG4UPskh5gT4m3J+jXzOFFGR8wSZbyp/L2Znw6USTFBj7ueLibeKmbkjBW1q6Cqe7jFGXhOrQiRBShatOLdf4kmo49T2Us0p7+yAYXVWBwP3WyOREXLX3RIalkr4jlUCg9mstRtg5QusjVwx0FaIqI+0/UwyK417zkXwhykspuAplb9PYcQZxYvTSOWpc1tTOpeMld4Iq5XFsIGbJxrE9NnpXT72pUlRwoxpii4hGM08p86V2FMpGg8A3yP/gbOCWMTJOQ/tAYdluNVhYtKHD8i9F21t3QlazEvGISYWZU3el+Xvq6QZVX2c5c/TQXJ2Yr0EzVjokjwNZ+AFEu9lraA29CRHWwrjoqbdtULbWW+pbCBvhshVKXKWV8B8u/6kX3bohMAOYqWy5FXbt2b7F7GLr0QmIOtiNQmp6kLOfPBTtG673/2pBRWqCdqw4QXMC6npuyECwqa/fUXakY8ByItolcU0ltF+5Bnc4bFKjnPfvvbTCEsGqiI/JSIZTatLdl6n5ObQ5FbGqNiUaitTvSIZQCJuM80kzqWr5PlBgaqQ7nb3QHSP5h0Q0/+S+viyv2t2gG4fz6PlylRDNGl8oqR1TLHOVfzvffh9w3U/H2snrgX1Bf0e/JrqZnJQxxl8VEaPBhLXfTOMkWGdmopBRuRg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB6147.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(346002)(366004)(396003)(39860400002)(136003)(376002)(451199018)(7696005)(71200400001)(186003)(86362001)(107886003)(478600001)(9686003)(26005)(316002)(33656002)(54906003)(76116006)(66556008)(66446008)(38070700005)(66476007)(64756008)(4326008)(55016003)(66946007)(8676002)(6916009)(38100700002)(41300700001)(52536014)(8936002)(6506007)(83380400001)(5660300002)(122000001)(2906002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-2022-jp?B?S2QydUJjWklEVXVsdGlrbldLMDRSUFI5UG1wQWh2UjRYakxhTnVGd2ls?=
 =?iso-2022-jp?B?Qmo0MDFjUEhWM1pwK3JoNnFRTmdYZG83bFpRV2U4TGh3TUpoVUNMMVZ0?=
 =?iso-2022-jp?B?bG03Q08xdVlGMXFRYWZtZTM2RitsbU5EZHByTlJJRm5DNkoyZjVDc2x3?=
 =?iso-2022-jp?B?dHAzczRtMG92dHA3WU9JOW84ZWJXbno3RlJFcnlJbjA5TVZkYkllL3pK?=
 =?iso-2022-jp?B?cUZOM0JuRUc1eSs4aktVMks2dnF0dWJ2MnNwMFprWmVOZW1obHR3NXA1?=
 =?iso-2022-jp?B?R2NoM0orcWJYdGpWVTV4cXRHY2Vnakl6SlE5d0lrTnBxVnB2NTR0bGc4?=
 =?iso-2022-jp?B?bmlnalNDVG8wL3ljUGtMeXZFbTVNQmdMWGNVWlk5ck5iT2txNHRXcnV6?=
 =?iso-2022-jp?B?Wm56RHE0T1pDMW9VYTZxd3dsZytSdzg4VTh3aW1ValNKeG1ySDlXb0Jl?=
 =?iso-2022-jp?B?REFTN3RhUUoremw1TllmOHR4V2RCYzluL1VFWHFBOHdhZjdRMFZHNVYy?=
 =?iso-2022-jp?B?SjFscFdoekluSmNCR1FuSzl2aHlZclBrREFNTW9sTFBEamlzalFGMG5q?=
 =?iso-2022-jp?B?b0FRUkJ6RENNMlpPRkluY1RyRDZDWnAvbWNWLzcybW1ZMUt6Y3lhREdM?=
 =?iso-2022-jp?B?eVZRV2xhWW84TUF2djlWVnBNWENURXgrZFVtSXhScHFQU0pYdkE5VXdI?=
 =?iso-2022-jp?B?T3VqcWoxMmEwOVNLSHVkMVg0ZU9KTTNuL1kwbkdVRHkvRFh3dGdZV1BM?=
 =?iso-2022-jp?B?amFYb3VtRjZHRzdLR0xBZEcyRXVYenFaTStDRnM3RnNJZlJUVGw2eGZD?=
 =?iso-2022-jp?B?Q3FnaXdDWXE3RUExWnZNMlBSbVR5R093L1A3U0RIQlF4TlZhNy9uK0xV?=
 =?iso-2022-jp?B?YUNvMlNINm5YczRreXE5NEhhaEhqYUJQYjh0Mmg4dHFNUTJoTUhNaVYx?=
 =?iso-2022-jp?B?aFFHbHNPOUx6Si9YZjZoc0lkOXllRjJ1M3IrMy9IdDVUR1IzYkRyd2lQ?=
 =?iso-2022-jp?B?NFcveGQ0TUNqT1VjZzExSHgrN0hXQUM5eVNpOVorcVliY1hsbjlSZFo2?=
 =?iso-2022-jp?B?MlF5d1FZeVV4VTNzMTlzYnJzcFlsQ08xeGpBZENVdHlHR2ZDSkZoeGZn?=
 =?iso-2022-jp?B?ZEsxalBWQkZzN1JBd2tzbGRNOXFkZXFYL3hHMU4vVGVBNkptenRWNTJE?=
 =?iso-2022-jp?B?cVRrNXV4YXIxdjdXYllEbWF5MFdwRXVEYy9la3cyQUFyRkpqV0JZanVv?=
 =?iso-2022-jp?B?THNNZzhERVpuUWxGSHFGRDFYWThhQXJuZlc0OHNid2lGVW1NbUlwTnM1?=
 =?iso-2022-jp?B?TzdzN05NTXFiRFhrRDlBam0rMUxuU3FXZnNjaDVQY29hYWt6TE83Qit5?=
 =?iso-2022-jp?B?aWE1U0JTcFQ3eERXNHRzRTE0NitIdjNBRW5xMU9CYUFva05Eb2pOdjlJ?=
 =?iso-2022-jp?B?MWZ0a0dvS2pFRUtlV1dHbnFNSUVMb2xoUE4rK2NTYlhYU2RRSWlZbVo4?=
 =?iso-2022-jp?B?RUlLSGczdDZMVHlYOFNrZWRSNE9hb0JUeTdLWDFVeFRaK3RWYlZDQVg4?=
 =?iso-2022-jp?B?TFhEaWFpOTZyM3hLdE9qdGNHZ1prZzFvT0Z5RUw2ZzlFR0ZlVU4vYmpz?=
 =?iso-2022-jp?B?ZWQ0Qi85SUJsN1EyRzdxN0M1S1NqUlBaVzBaZnFJbkgvenhDcnN2d1A1?=
 =?iso-2022-jp?B?MmhDVjI3b3JMNFhpZGFYNUdFZEx2SnhWZG9MeGduN0tpNHVZZWpWbkhW?=
 =?iso-2022-jp?B?bzZOR3Q0WVhjMXpYSVhNZHd5WUFTQzhENktFblhLZWtRaTBHWGdNWDdJ?=
 =?iso-2022-jp?B?M3RRUjMvQkhYdWZTQW9oZDI1TmNtdWdBMENIRnpHTnJYU2ZzdXdWMERC?=
 =?iso-2022-jp?B?UGJLYyt5L1ZHaExSOWowZjluTmtmM3UxLzFxK1NLM2pqdEYwM0ZuYzQ2?=
 =?iso-2022-jp?B?ZjJBZnJISkpjSFlUemcra0w3UC9vVFNoZDVSZnRCNTB4RUZFSGJvV2x4?=
 =?iso-2022-jp?B?Q3U1amNVZkx0QWFRNFVzNUg3ZXhFODQ0ckxmUnNQQ0tCb3dEMG5tQS84?=
 =?iso-2022-jp?B?NEEwTnYvZHZzb0hycnp1QTZDY0ZlMzQwOHRvV0F2WkRSaFlFYmZGd3pp?=
 =?iso-2022-jp?B?cXBKZUNnMGNmNWFFY1ZiSldUdjdmWUU3bXlhU3U4NDEwdjdUZENDUXY4?=
 =?iso-2022-jp?B?Q1dMN0lFS25SQzhySVN2ZWRIQ2N6Y2tMcVlUMHYxWDBGdjBMSmx2ZGs2?=
 =?iso-2022-jp?B?aHRDdzVWL2Rzbk1aL2FXbDU5dzV1R3BLNFJhcGtvTEpPeTJLMS9oaEIx?=
 =?iso-2022-jp?B?V280ZXpyKzAvRUZZSFViQjhScWJVWC9aYVhLTHBuOTJ0YWlSQ0pJSUcv?=
 =?iso-2022-jp?B?dG45UjQ9?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB6147.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e4319383-54b2-4be6-b69f-08db0036d7a0
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jan 2023 07:19:34.8456
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5PSGmB+hLjYCxMkr18f8DMX2HcFHZVryBhD4JyvJOH9hJUgr+Capg8Sa5Zb1/7iuAyynq1mCa794rauf+LVHQ8W5LMD++A3Kx683KmNHKFl7P/4Z1AVDY4EDMda7IMhP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB8735
X-OriginatorOrg: toshiba-tsip.com
MSSCP.TransferMailToMossAgent: 103
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 27 Jan 2023 07:19:48 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10497

Hi CIP-team,=20

I'm trying to use UUID in the kernel command line for selecting the boot ta=
rget(rootfs) with unified-kernel image. =20
Check the below details on how UUID is used to switch the partitions and le=
t me know what is the advantage of the initramfs script approach over UUID?

* Use filesystem UUID to specify the boot target (rootfs)
* UUID is generated for each filesystem and its value changes every release=
.
* Each unified kernel image is always generated with root=3DUUID=3D(The UUI=
D of corresponding filesystem) in its cmdline and .swu includes the pair of=
 unified kernel and rootfs.
* Install the update image using raw update type (i.e. block level).

Example:

Before update, Active partition: ROOTFS-A(mmcblk1p4):
sudo blkid
/dev/mmcblk1p4: LABEL=3D"ROOTFS1" UUID=3D"U1" TYPE=3D"ext4" PARTLABEL=3D"RO=
OTFS1" PARTUUID=3D"PARTUUID1"
/dev/mmcblk1p5: LABEL=3D"ROOTFS2" UUID=3D"U0" TYPE=3D"ext4" PARTLABEL=3D"RO=
OTFS2" PARTUUID=3D"PARTUUID2"

While building .swu
.swu includes...
a partition image (for ROOTFS-X) which UUID is U2
a unified kernel which cmdline includes root=3DUUID=3DU2

While installing the .swu for ROOTFS-B:
Unified kernel is installed to BOOT-B(mmcblk1p2)
The partition image is installed to ROOTFS-B(mmcblk1p5)

After update, Active partition: ROOTFS-B(mmcblk1p5):
sudo blkid
/dev/mmcblk1p4: LABEL=3D"ROOTFS1" UUID=3D"U1" TYPE=3D"ext4" PARTLABEL=3D"RO=
OTFS1" PARTUUID=3D"PARTUUID1"
/dev/mmcblk1p5: LABEL=3D"ROOTFS2" UUID=3D"U2" TYPE=3D"ext4" PARTLABEL=3D"RO=
OTFS2" PARTUUID=3D"PARTUUID2"

Thanks & Regards
Shivanand K


