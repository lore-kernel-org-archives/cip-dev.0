Return-Path: <nobuhiro1.iwamatsu@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9C93C00144
	for <webhook@archiver.kernel.org>; Thu,  4 Aug 2022 05:04:22 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.155])
 by mx.groups.io with SMTP id smtpd.web09.1415.1659589455372240632
 for <cip-dev@lists.cip-project.org>;
 Wed, 03 Aug 2022 22:04:16 -0700
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: toshiba.co.jp, ip: 210.130.202.155, mailfrom: nobuhiro1.iwamatsu@toshiba.co.jp)
Received: by mo-csw.securemx.jp (mx-mo-csw1516) id 2745466K016757;
 Thu, 4 Aug 2022 14:04:06 +0900
X-Iguazu-Qid: 34trPIPG9G3QzHKRzF
X-Iguazu-QSIG: v=2; s=0; t=1659589446; q=34trPIPG9G3QzHKRzF;
 m=nWLmBr2NDPzk27rpPCYGQ5Dc7rINYUeS7sJzNgP2vtw=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1513) id 274545mm024905
	(version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Thu, 4 Aug 2022 14:04:05 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LrwOS9y30P9ua84BzZ2Zq1ijR+m40uc3ipGXLAOOZp8/IVcEh39XqaBoC9Fhk/BMqLJcMKvgSSUdWCRBxW4AZgIisTaxR03n5LWf47+YCb0/cOFbz5h5cEnRIpJ1XGLM3cTA06oBMuE/NfxCe0nZD3qWKcI/fDMmDqmeJH1hJddpmQGt6jal03G7YDb4iIWoErAxGfYfG3Mxl4chkvBX4dukfoCw24UW2ps4jMrSnK69DSYndft4YqtLtF4lC6v7OvZEv22tS0ijGVHkn4N7courFkY61mgMEzNqWVlOvIFl6RRTpzd49gBw0WhxgmpSiHXC03KXG6/y2b3XGYl5Og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cqH8RM9/LHUuAr98aq8gsI9qgXxo2sTCyrNyvOb1by4=;
 b=RtNM0HDP++a9Pqy3LK6kmEJSalBmpkrgmbq6+mrNOnhhrb/PAsCWiQSOCMNX7tWW27ou/P6vAJaEKTVFEdMiZhP3BAXscXfGYUoq++n5jsVMFlLWMQNRlw/L2aO9N2vQO0h8tiH/2VG7Twy4nSBzNLtw5XkGYmPhlsCcFQKEOP065VD29kmciuWzevmZ24CcRLwXw4o9Z2oSBJ4U1l9I7GOapmTSZZp9+F62alc/NeYyJZ13iVNTU9oelNeD/apCmnUg8Kmefdnq5RvXFL+5C4ny2lHGCZQYoHqwnEGna2qPuAKd01LDScV/kLqCEtQPUJbpTGYui+IFFF0vHLZaVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <biju.das.jz@bp.renesas.com>, <cip-dev@lists.cip-project.org>,
        <pavel@denx.de>
CC: <chris.paterson2@renesas.com>, <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: RE: [PATCH 5.10.y-cip 00/13] Add more support to RZ/G2LC
Thread-Topic: [PATCH 5.10.y-cip 00/13] Add more support to RZ/G2LC
Thread-Index: AQHYp1mpLrGn/DUkIEWLAWuwmlwTu62eL7tA
Date: Thu, 4 Aug 2022 05:03:59 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TYWPR01MB9420B86CFD0071893D86D2A7929F9@TYWPR01MB9420.jpnprd01.prod.outlook.com>
References: <20220803165358.2156150-1-biju.das.jz@bp.renesas.com>
In-Reply-To: <20220803165358.2156150-1-biju.das.jz@bp.renesas.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 45129ebd-924a-4d3e-ee73-08da75d6bde6
x-ms-traffictypediagnostic: OSBPR01MB5141:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 FSLltsZGgDsKzf2w0l9/30wHAmCtGOhvI0Wd/+W1dDNYyJu8NnBofFhi8osGRvDWsx/rDkrOZ+QdojDdmDW2yU+p92LxU8tZHr4YflnfZk7awd4iu150h7Qzfho/RRZ2v3Dh1HTN1NALpQ6R3T1sKfFx3iZ+AAGvq6Wh3z1x6hvFrm73Ux4KudLIzFVOdVDz6j6BAbOQWTQhdYBToHLn8uO+jVIa/ivbFHzXYlby9PKBJS85d5gOYhHH/73iz1z5g6nn9kl5Tal5+ctj5DJRn4sjh+z8VhNtm4F7YYlgXCvu0I/tB6d8iRiuy+4R7VRbJhSW1EW6MgtAXJC8xZu0ysQEBN93ZRn3ayzdF0oextxKaZaNL7Chla7NAbRw4T7L3OIm0SByhna1VSariF3hI+yObH9RHKGSlgTat/dQ6KiyiWwBN6xFXhPrA1MF9xzV/MNIBi89WO0qx7wYXyicfgIc15u471N7ZipXx9l7B5FO/cBhdlIgLUcrkfqXzGv6GvotAOT1753qd5VMxtQ6iw/bceNOVp/4B9pyydpLxyxOdOQV8vBrQC9Wrh8D0CAAikBzPWwGh4dqrToY6H9GVEvuVkQTGGi6HAoQIoU9wSSDKAwiLi3sgSa8br0v4OpGgyx8yVATEM5DUJJMmXulP0ZuAbK4vT0HgIwnLtv2S0/KZZZDATbH1kMvTI1s+pR54vrX8vZ05bOWFVQBm6pd9HiMtlU4HmOt71yNmkcsug2vDb830KnhXamfG1J+OIcLGDfSAMADISxACuBxGIqSqf0nDDYYtU+mcDRcAEPl221j8ZOT2QsFag3WcEV8YKrcQCtrGAqB+P9Bu5Ousjw8IQ==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB9420.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(376002)(346002)(396003)(136003)(366004)(39860400002)(86362001)(83380400001)(26005)(53546011)(9686003)(6506007)(7696005)(186003)(2906002)(41300700001)(33656002)(122000001)(38100700002)(38070700005)(316002)(5660300002)(76116006)(110136005)(966005)(71200400001)(54906003)(4326008)(52536014)(8676002)(66446008)(55016003)(66476007)(8936002)(64756008)(66556008)(66946007)(478600001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?aUZZakpialdNQ3BLdnFPbXBZKzErU3BtQUlSbWltRzNncGxyTEZzQ0kz?=
 =?iso-2022-jp?B?TTF0MG81dVppYjdUK2laT1l6Z0gxcDBrd0QyUU8zdWhnWEUrN0VCOUd4?=
 =?iso-2022-jp?B?UU55bUtZL3BMUzZJUWNQWGg5d0VZSzFMa2FVUmpuUTlZOFcxUlNlZk9C?=
 =?iso-2022-jp?B?R1dIalcvWDlwV29UaU9HOEpPYlVqYjA1aTIzcWpjZkc4cTZoQm56dXhL?=
 =?iso-2022-jp?B?cHdnOEE1NmNOTXE0b29hbHB5UEZud3lCU3lJWVY4TjRKM2dFZkZiekhJ?=
 =?iso-2022-jp?B?ZE1lTktiMmVWcVhqV3dTM0txdnFiUlQrNzV4WXRXYmozdmtWMHFPL1Zy?=
 =?iso-2022-jp?B?dmo2OGxlMS9RTzZLakxhSHgxbkNYV0h6TW1LS1B5RG1KSS9tZ0JCME93?=
 =?iso-2022-jp?B?a1I1Wmoya1pqNTc0eUdoRk9pY3pTM3N0V096ZTA0S3dqQUxIRU9URnFW?=
 =?iso-2022-jp?B?SXJFYnBxMjdEZXMwSlZwd25JMXdtcUx2aDd5akR0THZSSjRCajlJM2dF?=
 =?iso-2022-jp?B?Q29Ea040RXJsYWlCNmdTUWdIa0Zsd2VLWDFKTmcwSHN5Q21JUVJ3SFNq?=
 =?iso-2022-jp?B?Y09zSXUzMDVKd0FFdGQ0UTZKNFR5UTNsZ3F1U0VGWEdTT2FRaFR4OEND?=
 =?iso-2022-jp?B?RUxiY0VJMTY0VDgrQzlQc295NU1pVExzVGUzRmZsNVlxc2dieUpQeW1i?=
 =?iso-2022-jp?B?Znp4NklKQXJ4eGRINUV5QXZhdUxuTzY2dXB2RDRlZXJhQUFGL01iOWZC?=
 =?iso-2022-jp?B?U0lFdXRiWFB3R25FNllBS25iOGU0WkptMlVwTlFXR1dIZk1nOGNxeXlm?=
 =?iso-2022-jp?B?UVorbmp1cndoSkpBd2FVNDBoRlc3a29sMkFIR1g5L0M4YTVqaHhPK3Vh?=
 =?iso-2022-jp?B?NG0ySlNwOHNzRzFsUmNDNlBhRTEwSW8xdjc2RGRFYmp4a2Y4MG1wb3Y1?=
 =?iso-2022-jp?B?STJmNDZ5SHJBZzZ1eG5xM3BvaUZnSm1jb1Z3VTJHR25vL1hTenM5Y0to?=
 =?iso-2022-jp?B?UHJacHIwT0w5TmNTSnphWDVjQWNveHRYYys5ZU1EWXhEaGt5YTlIYWxi?=
 =?iso-2022-jp?B?aFVYOXFvc2cxYU9SVGFGdHJLKy8wblp1QlRFV1FYZHp3RTVyc2IwenNS?=
 =?iso-2022-jp?B?YWViaG9DYmVqRUowYXBJYUkvZVp6ZVo4TUdHLzNzeUlxc3diN01yWXpn?=
 =?iso-2022-jp?B?d3hWY0FMc0E4dmtHOXUzNUwzUnE2Sm9XbEducExwQ2g1ZzNwRFgvVk05?=
 =?iso-2022-jp?B?bGZ1Vi8rZkIvWmhkbm5tMU5RZG9uR20wTlErNjh2NExUOWNIdHY1bVBE?=
 =?iso-2022-jp?B?bjFCaW1LTUpCZWpzdW9TOWdWYmJyaHVsZUljUThLamx5UDMwNm1Da25n?=
 =?iso-2022-jp?B?MXdxTHZmZDR3UXltN2k1elExaGhCa0dRL3l6Q2hwN1ZtSlN3VW1YUWtv?=
 =?iso-2022-jp?B?MjZ3L0t4VVlYVXZJc2tqZzh6LzRLVFdhVkZlU2c4ZUxNNDdLUVZRT21V?=
 =?iso-2022-jp?B?bXc4YlJjRk9RdXhtV3hSSDlRakg2SUIxY3E3clJYbzJXcTZ5SEwwcWlN?=
 =?iso-2022-jp?B?bXhha2l5RW5PVktYZGpiTzA5Y28xRSsva0hnajJ3MDk2aCtlU3JCbzZz?=
 =?iso-2022-jp?B?cHVTSU5CWnc5RXRpZWl6aVJHZFRMUVRpcUZRTU1XSXd2aENpLzlQK0RN?=
 =?iso-2022-jp?B?aC9OUFZWQXpHSjF6bXVZY2ZvOGdoUmdLb2crMThOUWNEVlFMTGdwL0do?=
 =?iso-2022-jp?B?YkZEL2N5bCs4b1Uwa01nWUM3UjRSYWNCLzgrMDlMU1BsaWg3aUpsZzFk?=
 =?iso-2022-jp?B?TCtZVThEdEVEdW53WnN3cHlnKzkzdlhQaWxMNHN2N2JTVi9ySFZMVlVi?=
 =?iso-2022-jp?B?M1VzQlRSWEpqTHI0QWo0bUJaeEtnTWg0bEFvYkFXUTBMV0N6emZ4a2pU?=
 =?iso-2022-jp?B?cnc0NmF4NHZQM0RSOXJVN2s0c0w5WWI0VGVHdDdNNG5XVFVid2RvMnFV?=
 =?iso-2022-jp?B?eEQ4YzhxUzZTNUhLWVZRVHYzWVBXTXJsVFVxVU81R1ZuaklHTXBkdVZj?=
 =?iso-2022-jp?B?eVRDK2xucXJYdmxoYjUrdU41NjFKZCtnaDBjbWV1WWFLOG9ZMFBDSEF0?=
 =?iso-2022-jp?B?NGw3WDRBbUFSaDNES01BNDlnc3pMNWViVFR5RkxlY1NrWk1yRG45eHhp?=
 =?iso-2022-jp?B?WnJ4Szl2T3h4enZMbERYU0pSOXovMm1SREJmdjhLTkU3dWxIaWNTZ3Bs?=
 =?iso-2022-jp?B?SGF1OVlBOFJNdlJMR2Q2eE0wYnZNOHJnaWFpMHpFTGlCQUc3Ly9JV0hq?=
 =?iso-2022-jp?B?TXV4ckNiVFU5bFA4RTUrMldjYmxrQ2VTS3c9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB9420.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 45129ebd-924a-4d3e-ee73-08da75d6bde6
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Aug 2022 05:03:59.5669
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 
 Nrd2lKUrBo1RiYlAEuCvrx16stKZdsDnCUxdcGUwrWxqXO1tAqt++0pnyKiCmG2QIl1fIe+PxdzEtOyD7GxUXHfm9/64dCG0pfOJWp/ijpdXIkRw7C2kRUCb+8Ckazdg
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSBPR01MB5141
X-OriginatorOrg: toshiba.co.jp
MSSCP.TransferMailToMossAgent: 103
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 04 Aug 2022 05:04:22 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9110

Hi,

> -----Original Message-----
> From: Biju Das <biju.das.jz@bp.renesas.com>
> Sent: Thursday, August 4, 2022 1:54 AM
> To: cip-dev@lists.cip-project.org; iwamatsu nobuhiro(=1B$B4d>>=1B(B =1B$B=
?.MN=1B(B =1B$B""#S#W#C"~#A=1B(B
> =1B$B#C#T=1B(B) <nobuhiro1.iwamatsu@toshiba.co.jp>; Pavel Machek
> <pavel@denx.de>
> Cc: Chris Paterson <chris.paterson2@renesas.com>; Biju Das
> <biju.das.jz@bp.renesas.com>; Prabhakar Mahadev Lad
> <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Subject: [PATCH 5.10.y-cip 00/13] Add more support to RZ/G2LC
>=20
> This patch series aims to add CANFD, WDT, USB2.0, AUDIO, Serial NOR Flash=
,
> OSTM and RSPI on SMARC EVK based on RZ/G2LC SoC.
>=20
> All these patches are cherry-picked from the mainline.
>=20
> Biju Das (12):
>   arm64: dts: renesas: rzg2lc-smarc: Enable CANFD channel 1
>   arm64: dts: renesas: rzg2lc-smarc: Use SW_SD0_DEV_SEL macro for
>     eMMC/SDHI device selection
>   arm64: dts: renesas: rzg2lc-smarc-som: Enable watchdog
>   arm64: dts: renesas: r9a07g044c2-smarc: Enable usb2.0
>   arm64: dts: renesas: rzg2lc-smarc-pinfunction: Sort the nodes
>   arm64: dts: renesas: rzg2l-smarc: Move out i2c3 and Audio codec from
>     common dtsi
>   arm64: dts: renesas: rzg2lc-smarc: Enable i2c{0,1,2}
>   arm64: dts: renesas: rzg2lc-smarc: Enable Audio
>   arm64: dts: renesas: rzg2lc-smarc-som: Enable serial NOR flash
>   arm64: dts: renesas: rzg2lc-smarc-som: Enable OSTM
>   arm64: dts: renesas: rzg2lc-smarc: Enable RSPI1 on carrier board
>   arm64: dts: renesas: rzg2l-smarc: Move gpios property of vccq_sdhi1
>     from common dtsi
>=20
> Geert Uytterhoeven (1):
>   arm64: dts: renesas: Align GPIO hog names with dtschema
>=20

I reviewed this series, LGTM.
I can apply this, if there are no other commands.
  https://gitlab.com/cip-project/cip-kernel/linux-cip/-/pipelines/604399902


Best regards,
  Nobuhiro


