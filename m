Return-Path: <nobuhiro1.iwamatsu@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13829C4345F
	for <webhook@archiver.kernel.org>; Thu, 18 Apr 2024 08:58:12 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.131])
 by mx.groups.io with SMTP id smtpd.web11.8206.1713430682861682868
 for <cip-dev@lists.cip-project.org>;
 Thu, 18 Apr 2024 01:58:03 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba.co.jp, ip: 210.130.202.131, mailfrom: nobuhiro1.iwamatsu@toshiba.co.jp)
Received: by mo-csw.securemx.jp (mx-mo-csw1120) id 43I8veix2736020; Thu, 18 Apr 2024 17:57:40 +0900
X-Iguazu-Qid: 2rWhclmqQjfkKiiUi1
X-Iguazu-QSIG: v=2; s=0; t=1713430660; q=2rWhclmqQjfkKiiUi1; m=EPa1CpJzZb3Jp+oNvJw2P5ZQxkmO4sH+iyEnWbR2kNA=
Received: from imx12-a.toshiba.co.jp ([38.106.60.135])
	by relay.securemx.jp (mx-mr1123) id 43I8vc3c3218048
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Thu, 18 Apr 2024 17:57:38 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I3CBJkb0m4pIePnNoM6xUXSzwacvxpL+kIYrAfID6pTe+T6iiZhE7BgXRI8nLkGc2cYh0tT9rG4Sy89MXawRiaVUr6kx+YtDvVmTpdz4fyB9d16MP5+lLMjtp3wxZZm5vVSu2vIv/rm43iXlVL/de+N7vjcjjpF3w1VvEIVYaCuR1G6orl5Ffu9e18TMGppndf2K8R0sQjyIMvrHy2aLq24qnZl/lCk0DhsLVLxmUXYfF1D3D8ZGIaA/SFuYFsjdOvjhPKeYg+hGvgCpJjjc7zC2SkEsv2iOMDG8mkBCBBDmrLp9nvat2G0xpgLKCJdmwgHBfx93vzhnEgxb8ei3pQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mRj4g5pOWKDAf/EH8kwkcsxDNHhENYWMgjpSY4kjR1Y=;
 b=Erb/VjXNXiRqGUmq8mSku46nFgyL7+FKCAzOEEpUMIJ+ClfZEabNwgZidaxaBFW3+2UTyxrkmxbGXs/NvijevBoNs+GSIo0olUAVi51H1HjHuqtdjZZYWu2RzqNMqWz6+69XLUwSX2EUJLIi+B8YAAs/RJ6KhOoud2/h9YoS9Mo8FSIz3FRi2rTLHEtCRFyDPSanslXMJl9Ruusi0tSQ7JHVmzI+o2XogBERA1h76iPdFf4fQZX5VGgta8OQRkcEovfZ2RztW1wSQXi6IMSW3cmjGSMrY0mv4EVHB71a+DPJ+v2DulmSjjuPMqWrJ1z6ez+wbaYgFhws70tmYD7E1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <cip-dev@lists.cip-project.org>
CC: <pavel@denx.de>, <jan.kiszka@siemens.com>, <uli@fpond.eu>,
        <Chris.Paterson2@renesas.com>, <masami.ichikawa@cybertrust.co.jp>
Subject: [ANNOUNCE] Release v6.1.86-cip19
Thread-Topic: [ANNOUNCE] Release v6.1.86-cip19
Thread-Index: AdqRbXvhZr39mr4rTG+NpczU8hzviw==
Date: Thu, 18 Apr 2024 08:57:36 +0000
X-TSB-HOP2: ON
Message-ID: 
 <OS0PR01MB6388C0966265BE0F5D294038920E2@OS0PR01MB6388.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB6388:EE_|OSZPR01MB6889:EE_
x-ms-office365-filtering-correlation-id: 526f512c-a9f9-41fd-9d2f-08dc5f8597de
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 ojWVJG71gPT3WQicszZLteMNrUm8aroGXXYixm9P9ao0mtJlK+xUCZuabXvcYid4ViW2f4Ds95TdRVtxKlQ/EQTB5tYrnJwaRInd7nmyjCP91aYVh49+V/p275VihmoXqfWENS3mSP5f6ooI6mh4OlNiYqbKO2vd0hCy1ZAZzhQ1HcrJFOZNDSFuuD4QMliObWunAXBJXmHlEMJEC/TOvPaOaJl17TPeX5fjxS/FXGylZeLABMse1PqcsTGNMPhIynYYcIYYsaKzn51B192Ap/8XSrOAA6JuNwO9ZaM6xegZxhf3vhTP4Yp853SpZXMFndgyD8YHtXlne/ZjVWvZnRXU1mPVKG2HjhXK3eb7Q81lkTUGy3xtrW3bPiBnLZ9f3OK17UFFehhNTKHMahuefk8zmc0zgu7KDyM7l7gJcFnCHppDGLlpE4nk7bvAQgVLFOjnsC6/PDbRk/1zkeme9MNRQgOXrkkKltJGQKQcbUVMPE1dnwCawO+pWzEsLUyyK2nev/MJtbzdM0fS2GOiHeV74UA0/CLDOgwgHsF3grA1rUY+FSSyPF1TfirjBPGhLMPalLXkEcDgUE6WmBH3BH1AXpYaU0/DYZ7mOtCXI3IZvrJD1XxWx9Y9EhfblnNWD4vVjXVQKNsgi3fdZ7MiLJuKS4+Zl12PjNmdr7fr0PPwax2wssZ6FPVKH9d0QruwnlSG2k/TWm4x3iJGlMBcL8L8BUP2cVeNscA5f6zBcWe7qu2kFcnSPGGIyDFVpohJ
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB6388.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007)(38070700009)(95630200002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?TFJONFg3UjJZOU5JUUdrRjBWd3hJKzJwOCtyT2F6eWdHRzZwdmxRbkJS?=
 =?iso-2022-jp?B?VWMxTjJMSnFBenlhaHptUzJUSEd4Q2VVb1dCVGViSmtCV3d2Q29neHV1?=
 =?iso-2022-jp?B?UzZBKy9RQjJaTXJrMzBTclRQcUNUSnBxYTdTY0ZnczJHckRxWUt4emdY?=
 =?iso-2022-jp?B?MjZkd3B2cG1LUVhLR0pKN3dnL29jZjQ0a2JQbVJ3UGEvUlZqOTh3eXVS?=
 =?iso-2022-jp?B?OU83c2N4eDR3emV0V1NoY2thNGF4ZjV1K3JKQkd0VUw0Ty9pQWJzTis5?=
 =?iso-2022-jp?B?aCtFUTh1SjgvNXJROVJNNG90dHNFQjFmS1J1L3E3d3pobkY5cWZtUkhy?=
 =?iso-2022-jp?B?WkhjRUJ6eGJSUG5UeEVYMGVYeGFjVlgyalRaS1IveFRWK2FmenBzVEJL?=
 =?iso-2022-jp?B?ZmtIVXVHZ3k0M1dmdzV0QnlxalhST05JdGxsK3JqMG02WUNZOUtodkFY?=
 =?iso-2022-jp?B?TGNDT0VVdzhTbHFTTDVVcGFuOU9FeWowbGtKSllLVUlzbGxBc0FwNEh0?=
 =?iso-2022-jp?B?Zmp1cDZ1ZGhBTnE5d0oyOE9TRi9tRVdiOGd1YVBtTW5KaEFJb05oNXFK?=
 =?iso-2022-jp?B?NUcybDZ4QXhaWnJHN01PR3dLNG9DUmF5c0piaGNLSnlnZkd4SHFDd1JC?=
 =?iso-2022-jp?B?OXZva0IrSUpSTm50WFU1aXNFais0TmxVa3gzbEg1bmNkSU15SllzaVV6?=
 =?iso-2022-jp?B?cXplVWc3K081cXhLQTRxQWo4VVZ6VzNTVmhTSUZSUHBZTDNPMDhwOWww?=
 =?iso-2022-jp?B?eGJHbUxuZkZsTGs5aTFaWmhtc2NvaEEzY2VzcEZ4TktNejFQRkY3VkY3?=
 =?iso-2022-jp?B?UWNHVTFRc1FJNkJoVkMyeUM0OTUxUmF5aTJKYjJyMW5McXY0YXhhT25V?=
 =?iso-2022-jp?B?R05yRS9kR29vWGVndWFrbHpKbTl6VXpoVDltS2w5QjlWcVhSd1I2Vysx?=
 =?iso-2022-jp?B?ZjJ6Um1yR0lFM0dCdnZyVWpmUnNsT2dPV2pWOG1scHp2Zk80eVdvQXdZ?=
 =?iso-2022-jp?B?TXhtSmxYcTkzVG41T2dmODFYZWNZNzFUL0pQN09TWmNCam9SWCs3RkZo?=
 =?iso-2022-jp?B?TndjOGxXV2xLb0xZUTNZd3RJajI0UTJRTTdFQmxiWFdaaC91RlRiOVh4?=
 =?iso-2022-jp?B?ZEtjTEwzNTlLSXlFTVFHWDhUZEMwa3pmcWVpcGJYRzRnYmRSUmJkTmZP?=
 =?iso-2022-jp?B?Sy9VUWMrTWR1SDFtZ2M2NldnUVE1bVVsVURmdmtTaHl3VExYaDgvbWZk?=
 =?iso-2022-jp?B?Z1lqSW9mcUptMStveTFJV3gwWnI5RGdReWdLM2dTM3pPY0xMUklQZjlw?=
 =?iso-2022-jp?B?MmZ3akxueng1ZUFEUWZMTmhqMzRHNjNxdFd0NEZXS3d3M1daMWJnN0JC?=
 =?iso-2022-jp?B?ZnNSZFEzSHNIZERubzFiSTE5M0RQUDdlTHc0OG1KZWhrRFVmVzJBVzI0?=
 =?iso-2022-jp?B?Z3BFM1h4NzF6aTNNTitjbmN1THErM2pmaDNhUmx5cmo2a254SkhkRjVm?=
 =?iso-2022-jp?B?UytOMFVvWjRHTlFlK0ZiQ3BBSVVGVDBmVUlQODVWUXRZOUpHTmNKRVNU?=
 =?iso-2022-jp?B?VEpyOXhuYmgwT2MyQzRJREp2L2UzY3huMWJxT0owV2pPUGxacjV3Titm?=
 =?iso-2022-jp?B?Nnp2VWt2KzZCVEN2d2dZWTdlM05TaktTQTJIOGdYa1BMZjk4QVVXLzJt?=
 =?iso-2022-jp?B?ZUkvOTIrRFhvSHM1RkNBd01WbXBacGdqL0g3RFBWczBlSDFLbTk1djJr?=
 =?iso-2022-jp?B?aWxvdGMvZ1F1TDlob0djZTkzcmM1bXZ1N1RnNlduUE1wbkNaMnJKcUNK?=
 =?iso-2022-jp?B?MXVhSWZvZjBna0VPU09DWkoyemhFT3M4d0JSbG5XM0FCNXJBZklmYjdj?=
 =?iso-2022-jp?B?N3Z4WGhJcmtRdHNoNzFYWHNLWFh1aWJFZE1JSTFtdkE4Sk12ajN1R21L?=
 =?iso-2022-jp?B?U1B0dzNnY08xYktaY0EwVU1PTGdCQ09UNmlaSVkwWE51dmNSMWlIQUkx?=
 =?iso-2022-jp?B?SWIvdVY5Sjc3Q0F0V0tyN1lla3RreXRIL295NnRRaGlPVzBhZ01yL29s?=
 =?iso-2022-jp?B?TWFvQ1Y2TjN2aG50akEwUUpjMEhycXlMTFpiTjJjc3hENDZadUtqQ05u?=
 =?iso-2022-jp?B?MHYybVpCNHNTVmlzYjBwcSs0b29FU1o4UktMa1lGOWV3c3NWdkNoQ1dU?=
 =?iso-2022-jp?B?MUcxZU5TdGNRK3ZHa0pXNEpCRUR4NEVDNmhSRk1xcmdQZldsMDJaaUk1?=
 =?iso-2022-jp?B?ZEFmTzN0WWJhTUVGSGk3d04yRHdBbUhEVnVJK09jdnIxczFaTjliMUkx?=
 =?iso-2022-jp?B?SDlHQ0ljclBGQy9DWmFaMzR0aE45R1NGRVE9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: toshiba.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB6388.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 526f512c-a9f9-41fd-9d2f-08dc5f8597de
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Apr 2024 08:57:36.2435
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Z9tOElaE7gnuoGgwhtasTLIZ7S2QoIrBJkgRFPBLpk1gRH1hjhnMOcdUzLWZ0hMfA7OzTceWfw1hIv5IkT4PRVap+rhoE0+DY7e8hwJrwAzHzuFxScRJ5yGOI/0sMYsk
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB6889
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 18 Apr 2024 08:58:12 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15576

Hi all,

CIP kernel team has released Linux kernel v6.1.86-cip19.
The linux-6.1.y-cip tree has been updated base version from v6.1.83 to v6.1=
.86.

You can get this release via the git tree at:

  v6.1.86-cip19:
    repository:
      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git
    branch:
      linux-6.1.y-cip
    commit hash:
      b72d10576403db55c087e515da69d332717119cd
    Fixed CVEs:
      CVE-2024-26817: amdkfd: use calloc instead of kzalloc to avoid intege=
r overflow
      CVE-2024-24857: Integer overflow bug was found in bluetooth device dr=
iver
      CVE-2024-24859: Race condition bug in sniff_{min,max}_interval_set() =
in bluetooth driver causes DoS
      CVE-2024-2201: Mitigations for the native BHI hardware vulnerabilty
      CVE-2024-26811: ksmbd: validate payload size in ipc response
      CVE-2024-24858: Race condition bug in bluetooth driver causes DoS
      CVE-2024-24861: Race condition bug was found in media/xc4000 device d=
river in xc4000 xc4000_get_frequency()
      CVE-2024-27437: vfio/pci: Disable auto-enable of exclusive INTx IRQ
      CVE-2023-47233: Use after Free bug in brcmf_cfg80211_detach
      CVE-2024-26584: net: tls: handle backlogging of crypto requests
      CVE-2024-26642: netfilter: nf_tables: disallow anonymous set with tim=
eout flag
      CVE-2024-25739: ubi: Check for too small LEB size in VTBL code
      CVE-2024-26810: vfio/pci: Lock external INTx masking ops
      CVE-2024-26813: vfio/platform: Create persistent IRQ handlers
      CVE-2024-26800: tls: fix use-after-free on failed backlog decryption
      CVE-2024-26814: vfio/fsl-mc: Block calling interrupt handler without =
trigger
      CVE-2024-26654: ALSA: sh: aica: reorder cleanup operations to avoid U=
AF bugs
      CVE-2024-26585: tls: fix race between tx work scheduling and socket c=
lose
      CVE-2024-26812: vfio/pci: Create persistent INTx handler
      CVE-2024-23307: Integer Overflow bug was found md/raid/raid5 modules
      CVE-2024-26643: netfilter: nf_tables: mark set as dead when unbinding=
 anonymous set with timeout
    added commits:
      CIP: Bump version suffix to -cip19 after merge from stable

Best regards,
   Nobuhiro


