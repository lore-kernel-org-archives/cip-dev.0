Return-Path: <nobuhiro1.iwamatsu@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B20FC46467
	for <webhook@archiver.kernel.org>; Fri, 20 Jan 2023 05:25:26 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.155])
 by mx.groups.io with SMTP id smtpd.web11.67998.1674192319086684368
 for <cip-dev@lists.cip-project.org>;
 Thu, 19 Jan 2023 21:25:19 -0800
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: toshiba.co.jp, ip: 210.130.202.155, mailfrom: nobuhiro1.iwamatsu@toshiba.co.jp)
Received: by mo-csw.securemx.jp (mx-mo-csw1516) id 30K5Ow3X017222; Fri, 20 Jan 2023 14:24:58 +0900
X-Iguazu-Qid: 34tMMX4CAAgi9jdfjD
X-Iguazu-QSIG: v=2; s=0; t=1674192298; q=34tMMX4CAAgi9jdfjD; m=/OqW5UfgwFR60is8DfrhvFu3LQYQ1PFaLQhXKjGzT1k=
Received: from imx12-a.toshiba.co.jp ([38.106.60.135])
	by relay.securemx.jp (mx-mr1510) id 30K5Os5R013106
	(version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Fri, 20 Jan 2023 14:24:55 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OxJ+HD5xkK1FBofwNhQHiRSWCPbmkwEk9jwbyTbnPeU7mQVqvbmOZzsSFb5csQ1Sc85gDIgoePlNLopr31e60VJ5UH5rcY9WUA+0SQIPA86L5gAgZyrGNQ3AU+4nDWoazkosCRkTaKTq3rEVxTmFAbqIZi93nLUGlTDlVqNNnHP1IjnTLJaJr5+3sHrb3T+CxJiLBvyDDaCw+CL4K17YIKrcGOu1/xSKZt4g8MlOkmChJI+pWq2QOAii4EOyCANxnWN0oA/uz2UZgGGXsacBaIOmPblyd0wiDpHdkENes4OWQX6T+h0x+7+NODYGgwhEIdy8Yfb0onvpfhRuNfY2LQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KG1C3JQANAVUC9OBIoHs2f22Ge57xY9+Dz/KwugTaqU=;
 b=RmH3J7dJJI8cy5j/6RU/N9NY8fET7LrW8tcYH/XAOr5VRL8SyANLfXx4uWfvH9dv9prnb1eIg/mT+vmyntyiUsBABBAkbhW93Raw1Ukb0VyXw4mgViNXWQ+xOe/HxAdREtOO6Ot4Xph6rDXMgLopy4nKlr3JTwxfAHbdf4zw4MTeAF05RLdsgTOZ94pIP+nV90tBFRf5Bpa6lWTrQgvUZg1hOw1BUOPaMh551iEerl0xo7X5htIDecq0i6hVwZF3ztbwOEvAeksPU6HNg0gBWigSpbvDq1HMXtaO/KbBzeIs/30qiGZXdJXsqeBFx6M9wutkfx8bsaoHOrZ/C0QYZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <cip-dev@lists.cip-project.org>
CC: <pavel@denx.de>, <uli@fpond.eu>, <Chris.Paterson2@renesas.com>,
        <masami.ichikawa@cybertrust.co.jp>, <jan.kiszka@siemens.com>
Subject: [ANNOUNCE] Release v4.19.270-cip89
Thread-Topic: [ANNOUNCE] Release v4.19.270-cip89
Thread-Index: Adksj2YCaiVsv0S4Rq2/QxzF78lHNg==
Date: Fri, 20 Jan 2023 05:24:52 +0000
X-TSB-HOP2: ON
Message-ID: <TYWPR01MB9420ED824797249617C3A25492C59@TYWPR01MB9420.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYWPR01MB9420:EE_|TYCPR01MB11495:EE_
x-ms-office365-filtering-correlation-id: fedb3a59-7c50-4506-6330-08dafaa6a84c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Nm1JKZLcSbXFTR001Xbj7edBcd4TOpnwqtjCBJC6jQyA/4KMZD3d28c7lc07xmjYxm6KvkQ5VlUDS0vMR1eJALeRXR0UmKgk1kZmcG8+gvXD21ryT/Qlw6gRyn0DG9+tC2dl9t2nVdAVnTz8VlvE8DlEg+lUc/zC0ISN5UTXXlffoIlMxE3TAiafJeJbZObFhMQQWvRsVZPNJlwpSlGdieiY+HEXX9N99Cn002CYiZhbZ1RBGG2q3rapmC16eTE8ieR4gchjEScTvukS9EPCwwjn4URdCp4X9Hzn1CEg306xLsejOHGEKLOXFErUJS3VN/mT8FpAQbvznfBTec+UwSY5JYSZIM3zNZJW5cHQR+DYZ9HC8wKu6HaAWLHPRZxJYFS0oSYR41bzjP7JGR9dq2jwg9Dd0Z6ziZCpj/ocqig4C3jaYPUV57TZYMaR3esRtD5RnyA6JpJ9Q3wRtlDaPUQ+BT7MUcEmnpHFb8Fy3d9c/RKE0JMcT8oWympsxFlPg4IpEEoMqTmd/4+PuJFqlc9KgnVVAPXqiMMGEQOJMXqr2lb1YhTLOAlfUlGf6tba3TxpLFlKBFINnoYwhHY83Jl4Se32/sdW0lItTtvY+W7coo1VovbPa+r7DnUdlA19Fkho2Q7qbAlXHFeAOaoi/abtbmkANhOCvI+zdpdaOWp1dbNhI0DdRYSzYvegbxNpKoKrwpe7pygbNm79kJmst6xKcS5DZZCGMGFTdPZ8+GY=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB9420.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(376002)(136003)(346002)(366004)(39860400002)(451199015)(33656002)(966005)(478600001)(76116006)(316002)(66556008)(66446008)(66476007)(66946007)(7696005)(71200400001)(54906003)(38070700005)(83380400001)(38100700002)(122000001)(6506007)(55236004)(55016003)(86362001)(26005)(186003)(9686003)(52536014)(5660300002)(8936002)(2906002)(4744005)(4326008)(8676002)(64756008)(6916009)(41300700001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-2022-jp?B?ZnhiSFNjODcyZlVSZW5WSXl4dG5JOWlFUHVJQUdPSFJ1WHFYRE10cURY?=
 =?iso-2022-jp?B?ODNIODVQeEcyQVFvT1pMY1NtTmphcDV0SzZKaTQzVDh3K1kxKzFibWdj?=
 =?iso-2022-jp?B?eHdZQTU1R3hPdXdxQWZTRExtTHYzZzBLQVA0dkxXRVprTWY0TzVsS2pN?=
 =?iso-2022-jp?B?cnJTWkE4QXAzRG83dktwSkd0RFJiMktiVDMxVW1IT3BhZGt6NHZCeHE3?=
 =?iso-2022-jp?B?RmNHMXFBcDZDREl0aFdYZW5VS3kxMVI2V25QNmNTaENUMkhEVGtvVkFF?=
 =?iso-2022-jp?B?Z2k1YWdJNUJyMldZS2NScFAvaGV5RWkwR3RrU1BBMXVZa0NGdE9rQ0tR?=
 =?iso-2022-jp?B?NnU0Q0FWMGRSVjUwV2VFSzUxMnZ3SXhiWU94VUpxdEVOQW1nemgydlFi?=
 =?iso-2022-jp?B?NU9yaEFKNUltL09WUS83YzMxcEt6NlRETm5JMzgwdDFYSWovOVhON0tJ?=
 =?iso-2022-jp?B?dDdFditKaW9RazB5TEVOOHlja3hLSGovelNsQmh5and6Y2Npcmk0VnNZ?=
 =?iso-2022-jp?B?WlhWa0FNd0J2a0pKTW1CWFN6YnNHVjVaSU5aZ3o4UFE3bkNoWnJDb0NT?=
 =?iso-2022-jp?B?L2R5Mjl2aTh1eG1iL3B5N2l4T1hMR2tjVVppOFE3a1k0T0dNVENXcWpw?=
 =?iso-2022-jp?B?Nzg0MmJ0S1lDYjcvRFlJK3pJU09MSlBFUmF4L2MvaythWFNGdGErOWFs?=
 =?iso-2022-jp?B?a0dqUXhtMEN4UDg0cXdiK0k2eCtjUnJBbzJvays1aWM3dVlud2VEUGIv?=
 =?iso-2022-jp?B?MStSOHMxK2k2OHpQYTU1U1R6ZmFrai9rV2tMZm5Ed285cFlncUxXdmhh?=
 =?iso-2022-jp?B?OTRNK0VMenhjZG9XNUZHUkpYR3c1L3MyYnlIb29WVzUrMmpta1RzWWlw?=
 =?iso-2022-jp?B?NTRHaGk0MjZDb1paZmdWZCtqNW9pYlByQTQyOHZUbXRjSjg2NFRibzJF?=
 =?iso-2022-jp?B?ZlpKdkJVVzg2RHI0dVpkZHliemNjMUU5cGNNeEVvWFVJMTZiL3hHRzlr?=
 =?iso-2022-jp?B?c2tYL1ZPc2ZmUnpwaTM0QW5Gb1k4bktSdk1iYWF5YlAwVjlLSGMrdUtq?=
 =?iso-2022-jp?B?aXhjWU4xMkN4TkV5dGNHODdPUUNUa1lGVllNOGJGcWswWW5HQUlJckpT?=
 =?iso-2022-jp?B?SG9yL0RySGpNYXF2UUFOWWJzWGxlSWxUOHNrd0JMN3dHVjJkRyswU0l4?=
 =?iso-2022-jp?B?eHVjZ25STnlnTlc2bkI0UTM2Z0hvTGQ3U2EyYW1sVVhRZkRWMXdQKzNy?=
 =?iso-2022-jp?B?MnNRUGlSNG1uWHgwNkI4RHJEaXdFdmlHYWpjbWx0eS9zbFJrVmx3clB5?=
 =?iso-2022-jp?B?YXdDREZHOGd1TWpxa0w5UDk4N0k2UEFTajNMS2FCV1pEaVZOSERFcnhy?=
 =?iso-2022-jp?B?Y2ZSOW1QYXY2NUR3YnQ1STRodmMxL2lpM2xySTNrV20zUzV6VFh2bmhn?=
 =?iso-2022-jp?B?akJDeGdONnRQWXRwbmNobXNnTk5pS001NUVnZ1g5TjVJc0N2cXdJd1hz?=
 =?iso-2022-jp?B?U29VU3FXNWtVWXVyL05wWTdvNkZaQjZCWEZEeFJqWW53Ryt4S1NscWY0?=
 =?iso-2022-jp?B?WkxQNmRzVUlXeEplelRadXlCcTJUeGdpKzZvSngwbjZRSU9tQm9oSzky?=
 =?iso-2022-jp?B?NnZqU0NSNVAweHZQcnBzaVZ5SktEQ3JuZGV0WFRKOHZwR1lGbWtJZm50?=
 =?iso-2022-jp?B?OEFSL21NN1A1SWFtZmdGbkZPSkdqOHFSdzZSM0llZUhEUTdYdTB4d3hM?=
 =?iso-2022-jp?B?cmZBeExPK216RFBjRCt0WjFKMzdUdndRazloMHNhZ2JyYjZKVzd6Qko2?=
 =?iso-2022-jp?B?MkZtVURVZXJGWTdmcFJINC91V3dwY3d2RGNQZEZONERVNXRCdWhVRW1z?=
 =?iso-2022-jp?B?WFU1ZXljSGh1aDBSRy9ZcWR3Wk10VVBXOEhEemtrNVBCTjVGMlFXSG54?=
 =?iso-2022-jp?B?bm9HWFl6dzVjdnI3aTUzRDQwL25yc3p0RXZPcFowSHROUFVjanZqYmJM?=
 =?iso-2022-jp?B?bFppTlp5TzMrVTMvQmdXQ2UreXFtL3NFbHU2RlBESFpiZnlIUVpWMWNS?=
 =?iso-2022-jp?B?MFBBOFQybmpOcVQ3N0wxU21DbHh0VWoyMjNIVHQ1RGxKaEwrZ010WEtt?=
 =?iso-2022-jp?B?VVVpYWhkK1ZDYjhMUDdJblhKR1YxVktaajJBSk5HTXp2WXpUV0pNaDlq?=
 =?iso-2022-jp?B?R1ZjakRyWkFCdFBtcFpwOXBjeHdDMGtUM2JONm9vaDExL2lKRkF2QVE1?=
 =?iso-2022-jp?B?QnhMTmhUcXA3eWpZY0NxVzdiNjBDa0hZalB3TVQxL1g5WnYvN2kwdXJt?=
 =?iso-2022-jp?B?OUluZjdpQWFKajRFakRuWGFOSEFXc1RTOGc9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB9420.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fedb3a59-7c50-4506-6330-08dafaa6a84c
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jan 2023 05:24:52.1127
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kzBBdpRO4s8O8ieL41TtB+ONdjUedhh4tthMTp+4jzfCCeiztvcXpOVQ4al1M7CRVbLGG2zOnpU5BWbXettrolPfyX+plfHg5YgmujFIjOZRwtdxW81aL1upxlFaf/xD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB11495
X-OriginatorOrg: toshiba.co.jp
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 20 Jan 2023 05:25:26 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10451

Hi all,

CIP kernel team has released Linux kernel v4.19.270-cip89.
The linux-4.19.y-cip tree has been updated base version from v4.19.269 to
v4.19.270, and there is no CIP-specific update in this release.

You can get this release via the git tree at:

  v4.19.270-cip89:
    repository:
      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git
    branch:
      linux-4.19.y-cip
    commit hash:
      8cbf38242b91f4f98d6fc776bae10cc74740eff2
    Fixed CVEs:
      None
    added commits:
      CIP: Bump version suffix to -cip89 after merge from stable

Best regards,
   Nobuhiro



