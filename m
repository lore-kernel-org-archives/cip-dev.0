Return-Path: <nobuhiro1.iwamatsu@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CE6CC4707B
	for <webhook@archiver.kernel.org>; Sat, 13 Jan 2024 04:56:18 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.135])
 by mx.groups.io with SMTP id smtpd.web10.13974.1705121774294052311
 for <cip-dev@lists.cip-project.org>;
 Fri, 12 Jan 2024 20:56:15 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba.co.jp, ip: 210.130.202.135, mailfrom: nobuhiro1.iwamatsu@toshiba.co.jp)
Received: by mo-csw.securemx.jp (mx-mo-csw1801) id 40D4tmbV4045558; Sat, 13 Jan 2024 13:55:48 +0900
X-Iguazu-Qid: 2yAbQ1e1ZGHq8bKsvi
X-Iguazu-QSIG: v=2; s=0; t=1705121747; q=2yAbQ1e1ZGHq8bKsvi; m=32RyXBBCDgRxqsVjnvTLgP5KYCqZBq27xyV1a3uCK4c=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1802) id 40D4tjT03694034
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Sat, 13 Jan 2024 13:55:45 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HbYjnFr3YMZn04WNwYw0fjamhvG4Tehc0rwUUGDxTP8lHf1V6cWWL60krIlSL6Tr0OG8eNh2ud+RJmz8IDn5QWErWDoR00bzkijuCwFLFCsTcGlNVh3VfbPsUbf7BwY8PLbEWdGPIsOeaK5nSrM1AmxRRzFv6UDD8dj1GiUkxy/DJ6f1DYAEv8ZsejjpYNYNHk80Oe6b3zG6FrHs+xbsZi8PoSnDRAw2d8d/yj9R4g0hzDFA6HxjnU1xKtWmJchVnOYCSTCRS3jBl62VUCfdpIAOWFTh3/3jv6S6uYOK+QoWxUT/WGAQxq8CAy5rP6KYNpL4qz3T3imxcRK8pvATpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=unNd+7przygBXWk6NeyuKu24sISay+Rhl7COAPVkfo4=;
 b=L/3U2cZos4Vs5KL0DUBItdvMfw/LwskxxxQdf5DnFRJ2+hD4f+ttBntAqggjrcc/RKLW4983k+EGB/lw5uOJkJgBW5lyH4CkctzCs/LGIs3uckGJNmEPVuXZ2T+HNdvrLBi9X1NokX9s12csP0JNE8jfdzNV9SqvN0EMLxR1lsQUsMxWDGj/hE/swGGjGt60KuApFWLpkuU7bw6JdkhYXKhdbZ4M5v9PgQf37JNdsMHuFlmBGwzO69C5L+hqCGw2mtba/LJHJTr/gnQzMUa0K5KIMEGEfBeuvvl+Nagzff5juDfXtOwoazDk7cT/sq79aalksxUAcFynd2kOvstd9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <cip-dev@lists.cip-project.org>
CC: <pavel@denx.de>, <uli@fpond.eu>, <Chris.Paterson2@renesas.com>,
        <jan.kiszka@siemens.com>, <masami.ichikawa@cybertrust.co.jp>
Subject: [ANNOUNCE] Release v4.19.304-cip106 v6.1.72-cip13
Thread-Topic: [ANNOUNCE] Release v4.19.304-cip106 v6.1.72-cip13
Thread-Index: AdpF3I5BvtOFCptKSPq70r13AdXH+w==
Date: Sat, 13 Jan 2024 04:55:43 +0000
X-TSB-HOP2: ON
Message-ID: 
 <OS0PR01MB6388D8875E335EAFFA242BE1926E2@OS0PR01MB6388.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB6388:EE_|TYTPR01MB11014:EE_
x-ms-office365-filtering-correlation-id: 77dd819f-dd88-43f9-ff98-08dc13f3e5bc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 3xRPrqJJVh2oZL1X98wMnI05LiqqCS44h6i3DkFiKr920BlWPyrrBpk2TznZpVsc9G532Pk8ri4U/TA6CthR3WrzXtr+e3n+Tsm7NURI86G7PxflImCi2sZCkv4yO+1v1JYQX/84g4IqrcuTuTR5CJ/jIlTXxUTen7qkOFhsMqiGDUWnZDfGiQIZgFKJrkjDrGAx0uLOhl6i7NGAcNnMiiKBlU2TQ6G3Gay39Ip+vnRefXHmQXexsynG2PFrrk/spSCYVCpC30FwCcz4EsT3XD/a9uAAGeSbaXO0iBgkm9g9MfUNm26ZWtGGCj3NzE/PSqXI0vFWsIvTJsCfxTWa7ormPalWMTkZRYNP6U4/OOsa2VQcshf0wmyaTckUnmfbvMz8zoRPrIUDwqDnwjJBX6qCk4gcpXIKI8QQH13cc1HBx1lXaVZy7rErZ1pxL+/tQ2fao0ImaWem2YKnxoCUkw7xSoRhbOuHVq/DsmGDdqkr/zs0bVSsfApdlzhIfPlQDD3tA2eVjVY6aenU9tGTdD31PRxot/ngtRY7b4alFJ4nuZ7G+FBWl6UwBv6BdwmCvEOGCGLeYwABB6EsJujXK83o7D2qp0fkW/cCtM6Ucg+Q9UzGnZAFy8+F0++FWWwnUlX5Xd2EWdjSSfIGn/IbYQ==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB6388.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(136003)(396003)(39860400002)(366004)(230922051799003)(64100799003)(186009)(1800799012)(451199024)(8936002)(52536014)(8676002)(2906002)(5660300002)(4326008)(71200400001)(9686003)(6506007)(7696005)(64756008)(54906003)(66476007)(66556008)(66446008)(66946007)(76116006)(6916009)(966005)(316002)(478600001)(41300700001)(38100700002)(122000001)(86362001)(38070700009)(83380400001)(55016003)(26005)(33656002)(95630200002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?blpTbTM0VXh6TFp0OGxDSlpUWC9hc1lMVEJ0ZXpkaEx0V3VlNHBTY0hL?=
 =?iso-2022-jp?B?bER6Q0RSTFVyVExaTThFa0dyQWFsWW5GeEoyRGJJcVJiOTcxS3NobGY2?=
 =?iso-2022-jp?B?SVJVYk4rRkpyNEZtZG5YTVdmZHlickNXWGVkRE9HQjUzUDc3TWY4dFY0?=
 =?iso-2022-jp?B?NHQva0R1TTlEOWI3bThzVG5QalR5NE5idzVNNUlzdFdLU2lQa1NDRkdO?=
 =?iso-2022-jp?B?MThBL2I3UVBRTHdNcmw1WVdNMWNtMStJeU9FVTl3V1pZMG1kcGp1Qi9M?=
 =?iso-2022-jp?B?YkczalpNVkhCVWkyaE1RTGhkTE9WUkZwR3R1NlVrSWVUSVdPQlZSdURo?=
 =?iso-2022-jp?B?bCsza3ZqR1VkOFB3cTZZT2oybU9ZVDN6WGtvTURtd1NrRm96WUVjdTRq?=
 =?iso-2022-jp?B?UnhqUkEyN3dLOStJenVVS0hSSU5yQk45SlVTQkZDcXFvY3lId1J1VSsx?=
 =?iso-2022-jp?B?STd6bkRLeG1ud2crd083NVlNbUJOVS9TQUt4R1BzTXdFK0cxbnpFL1R4?=
 =?iso-2022-jp?B?NW9OTWhRUFhDS21iNWlPSUFuaTJycWhZY3ViRnNvTlExZnhRd2NieGoz?=
 =?iso-2022-jp?B?eE90YVlqZzdMeUJmLzBUN1RaSCt1S0ttZDV3M21aSEZEdDN2Z1pKMkJB?=
 =?iso-2022-jp?B?eVBGN2RkRTNBYTJJRklXcTI1NTlkdmhocXFqUm9kYWg5dVZSRGxnMHEz?=
 =?iso-2022-jp?B?VTlrdzBkY2JhM3FFSW5ac0JjS1NWVDhRbUJwazdIQ3ZnWk5SL2l5ZkRt?=
 =?iso-2022-jp?B?SVB1L1VCR2NmZWRJQUVGdUFVRW5VK1VYTnVQYmthQUZxbElNY25oeitP?=
 =?iso-2022-jp?B?NXFOb2VjQXpJSnB5aC93RG1MTWZzek1EWVE5KzlIWXdXWUVQTHpFc3N1?=
 =?iso-2022-jp?B?Mk5KcXRrWDFOZnVUSzU3dk9sdlJqV1JYQndwMWhCQTkzMzRTTkZjMTVi?=
 =?iso-2022-jp?B?OG1aWU9hVGJqVnRoU0t2VnJMMC8vRDU4Z3QyRTd2c1hiV1V5dFpJVzQx?=
 =?iso-2022-jp?B?MEZ5WFhmM0lrVkdiVUlOdlVuTk5zSmgxdU5FTDFnVU5qVllYT2Y3djJZ?=
 =?iso-2022-jp?B?R2ZLR1RXZitmK2RBbHVnajVIY3h0NTJXSW1VTkNYSG04SnZBNWhOeG1r?=
 =?iso-2022-jp?B?bHJiYklrUjNwdUxkSGdsTy82N0I2RTJ2ZHNUd05JU09VeG4zUTJZWlNF?=
 =?iso-2022-jp?B?bmVlcU9NTlUvamYvWTBQeTlYc1BydEx1SjZVQ0pwYUxJaXQzUHpaVkpr?=
 =?iso-2022-jp?B?SUdrR1dLRXRhcVRkZ25iMlRQc2tjSGY0RG5OTWY5b0Z3NzlPc29US2No?=
 =?iso-2022-jp?B?NnJ1QTc2Q3phM242MWJvMm1yZFBXanpLOUJCOU1MWng0cU9PcjdBbUpU?=
 =?iso-2022-jp?B?NDhMd09GMGdMbE5tQzVpbkJCcEJBd1hTWGE2ZFpVTTVFclFwTXFsRlZm?=
 =?iso-2022-jp?B?Tldhc1hyTzVSelBQNW5WRW90OGU2emFGNlNqUWVHRmZ6THB2SWwwWEMz?=
 =?iso-2022-jp?B?U3ptd3ZpRUVMV2ZDYUowaU9kOHFCTGZxeXl6RVRBaDJ0YWl0QVRWNm5r?=
 =?iso-2022-jp?B?U05OcXBCMDNVSERqOWxoTHFqbEhreDN5OGtlZWpnYldpZ1ZIZ0ZFVG11?=
 =?iso-2022-jp?B?aHZZRkxwZkZselc0V29jZWlJd2VST2xrRi9rRm5OWWxiNUtXVmNzZTFH?=
 =?iso-2022-jp?B?WURKUDl2RmVGbjBnVmlqWDUwVWM3ZCszTnhTdllqaC9IcVJuY3BwVTU1?=
 =?iso-2022-jp?B?dkcwQ053T3RlSFphUlp2c3lCZkdHNVZuWEN0OXYxdU1YbncxMUw5dlRa?=
 =?iso-2022-jp?B?Q3NwbGlkZzZFdVA0Rm1qR3lldGNjakt3MGdKOGJsQlNnMGdRNUxwNU9J?=
 =?iso-2022-jp?B?R3crUVRaRUsyTnFtUEpXaTB5K2dvY3hwaHNDdWs1aXFGRWcrWWhESkI1?=
 =?iso-2022-jp?B?V1o1VFd6bE92SUh1Mm9maUthdnF5S0huZXp2SGZxMlovSm5lRlZiQ0h3?=
 =?iso-2022-jp?B?OUFPdk0wbDVXRTRhZWd2RlpTQUR0TVRLakhvYytyUjNhdE12MjRjUnc2?=
 =?iso-2022-jp?B?VWVsWVhJUUxlRStCZEZKYVlyWXQwQTNqaGNtMDhNeHh3TnEyWEMxQzMw?=
 =?iso-2022-jp?B?MnFuYmloMWJ1c0M3L04vcDhHZTIycDRSV0R5ekMrWFZvTEovVGwxUlo5?=
 =?iso-2022-jp?B?U1VJNk4xWE9oUUhJU1N4VzFJeXQrU0VsTGxLSGRmbGN4OWtEQTRHNjkv?=
 =?iso-2022-jp?B?amJrdHB3UDZ0d0p3NzhRU2VaOFpVcnRiL3pwVjdvb0kzOTB2Q1RBNkxs?=
 =?iso-2022-jp?B?Y1dBWjdqKzIrUGgvUVNPdVNNY3pzdTNZdkE9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: toshiba.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB6388.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 77dd819f-dd88-43f9-ff98-08dc13f3e5bc
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jan 2024 04:55:43.1725
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CwQLFMvNyiuz4VSzqxg1PoL5S4tkXB12yf+1l4WK1Kz7CgvNWRTc8gtQ4cVrW1kkK+PHXkyTEF4vYOKAtnnn3ZrPVKPFbAecmXcUus3xXbYy8w0iDXBfeje/rqNX5r4E
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYTPR01MB11014
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sat, 13 Jan 2024 04:56:18 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14356

Hi all,

CIP kernel team has released Linux kernel v4.19.304-cip106 and v6.1.72-cip1=
3.
The linux-4.19.y-cip tree has been updated base version from v4.19.299 to v=
4.19.304, and linux-6.1.y-cip tree has been updated base version from v6.1.=
67 to v6.1.72.

You can get this release via the git tree at:

  v4.19.304-cip106:
    repository:
      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git
    branch:
      linux-4.19.y-cip
    commit hash:
      6617f4528449a329abd3b2dab36052b341610d99
    Fixed CVEs:
      CVE-2023-0590: net: sched: fix race condition in qdisc_graft()
      CVE-2023-6932: ipv4: igmp: fix refcnt uaf issue when receiving igmp q=
uery packet
      CVE-2023-25775: Improper access control in the Intel(R) Ethernet Cont=
roller RDMA driver for
                      linux before version 1.9.30 may allow an unauthentica=
ted user to
                      potentially enable escalation of privilege via networ=
k access.
      CVE-2023-6931: perf: Fix perf_event_validate_size()
      CVE-2023-51781: appletalk: Fix Use-After-Free in atalk_ioctl
      CVE-2023-51782: net/rose: Fix Use-After-Free in rose_ioctl
      CVE-2023-51780: atm: Fix Use-After-Free in do_vcc_ioctl
      CVE-2023-6606: Out-Of-Bounds Read vulnerability in smbCalcSize
    added commits:
      CIP: Bump version suffix to -cip106 after merge from stable

  v6.1.72-cip13:
    repository:
      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git
    branch:
      linux-6.1.y-cip
    commit hash:
      847d28968b6f4ca12f696d32771f7309efb14c83
    Fixed CVEs:
      CVE-2023-51781: appletalk: Fix Use-After-Free in atalk_ioctl
      CVE-2023-51782: net/rose: Fix Use-After-Free in rose_ioctl
      CVE-2023-51780: atm: Fix Use-After-Free in do_vcc_ioctl
      CVE-2023-6931: perf: Fix perf_event_validate_size()
      CVE-2023-6817: Netfilter did not skip inactive elements during set wa=
lk, leading to a
                     double-free or other unknown impacts.
      CVE-2023-6622: netfilter: nf_tables: bail out on mismatching dynset a=
nd set expressions
      CVE-2023-1193: use-after-free in setup_async_work()
      CVE-2024-0193: netfilter: nf_tables: skip set commit for deleted/dest=
royed sets
      CVE-2024-0228: [netfilter: nf_tables: skip set commit for deleted/des=
troyed sets]
      CVE-2023-6606: Out-Of-Bounds Read vulnerability in smbCalcSize
      CVE-2023-51779: Bluetooth: af_bluetooth: Fix Use-After-Free in bt_soc=
k_recvmsg
    added commits:
      CIP: Bump version suffix to -cip13 after merge from stable

Best regards,
   Nobuhiro


