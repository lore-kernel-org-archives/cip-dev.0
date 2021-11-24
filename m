Return-Path: <nobuhiro1.iwamatsu@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03CECC433F5
	for <webhook@archiver.kernel.org>; Wed, 24 Nov 2021 07:50:22 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.158])
 by mx.groups.io with SMTP id smtpd.web11.3357.1637740218834701391
 for <cip-dev@lists.cip-project.org>;
 Tue, 23 Nov 2021 23:50:20 -0800
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: toshiba.co.jp, ip: 210.130.202.158, mailfrom: nobuhiro1.iwamatsu@toshiba.co.jp)
Received: by mo-csw.securemx.jp (mx-mo-csw1116) id 1AO7oG97018511;
 Wed, 24 Nov 2021 16:50:16 +0900
X-Iguazu-Qid: 2wGrVQwHHHUTMs0BSl
X-Iguazu-QSIG: v=2; s=0; t=1637740215; q=2wGrVQwHHHUTMs0BSl;
 m=iDu+Qcb/qHpvcjoG6qrR1QBAOaEXpUMuotfg7AZiGTU=
Received: from imx12-a.toshiba.co.jp (imx12-a.toshiba.co.jp [61.202.160.135])
	by relay.securemx.jp (mx-mr1112) id 1AO7oFQL001088
	(version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Wed, 24 Nov 2021 16:50:15 +0900
Received: from enc02.toshiba.co.jp (enc02.toshiba.co.jp [61.202.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by imx12-a.toshiba.co.jp (Postfix) with ESMTPS id 509901000E7;
	Wed, 24 Nov 2021 16:50:15 +0900 (JST)
Received: from hop101.toshiba.co.jp ([133.199.85.107])
	by enc02.toshiba.co.jp  with ESMTP id 1AO7oEBJ022467;
	Wed, 24 Nov 2021 16:50:15 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AAhmzO5+QAx4paoNeW2viUE40rrSgKsI1oc7H/YHhFgWnJTd0lHTGbOQvxXygAc6haJ/+mu2apVMfoTxKP9Ceg2igLrKrDcyzgqDJoGGxW7fHCtRbLAI39JvWHZCi7lpLIUeEZwlXKr8JhVO7Ruv93nZvsPVKMJlcttRoi4k29Z5a+X1HstOmGXCzl8P/gAem9kbkLrVnTAA1weOeDYuCiuKolJ4P0kq2BI8FgBY1sL8h+EYDVf/9O1+j6PutYxfDyG5qC4JR4+QJNp3w4ynbSfRLUEAnE5IGlkuJotMXcNQ+SfWSQZrpdyjNNdk20/YQJjv3vUm0/Oj2el6y6GqTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3bcSDJFA94nNJsBnvkym0ImM/8YKUvArnDh8+cKabvA=;
 b=YokFyMYNEGlu2qDWPIe+1Vq4QEb7UZTrvqE6B7eLsUY9fxjP9VlLhysajxQ4VqEi54uILXXdLA0ysv+oKYWtxe4jNY1aw0fYpkPgmm/+VoVb0zQDcFK/6eIeml7nsX4V25lOd3Q0jzo26hGrFeRrsqxyFoFWVaYd5mZ4XxJZQV6uq8ks07NaQB6sz21RnPOpYDKcXoadC9Dci4COQC2UuJb7l9CCQPPIpLH05NLsCf/Ze7dpPEPxsvmtFEUzXl+VApgcGVDoMD2umaos8Q7NaxYco6rUBDEsGMfBWcFNisfISPWomIfl2oWaCb5MqL/XWI3+2NgTyzI9tMt73KHfFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <jan.kiszka@siemens.com>, <quirin.gylstorff@siemens.com>,
        <cip-dev@lists.cip-project.org>
Subject: Re: [cip-dev][cip-kernel-config][PATCH 0/2] Add options for read-only
 rootfs
Thread-Topic: [cip-dev][cip-kernel-config][PATCH 0/2] Add options for
 read-only rootfs
Thread-Index: AQHX1+PAp5dchj44SE+/SPFwc2mV+awSXDqAgAABEWU=
Date: Wed, 24 Nov 2021 07:50:10 +0000
X-TSB-HOP: ON
Message-ID: 
 <TYAPR01MB6252D1522C0F0CC258ABBBA492619@TYAPR01MB6252.jpnprd01.prod.outlook.com>
References: <20211112163820.1701453-1-Quirin.Gylstorff@siemens.com>
 <b2760c82-8bb4-5fbc-74b3-5a1d2ef78c7a@siemens.com>
In-Reply-To: <b2760c82-8bb4-5fbc-74b3-5a1d2ef78c7a@siemens.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
suggested_attachment_session_id: b84954e8-b9cf-b0c7-957e-e2d754d1ad99
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 791fe5f6-fa4b-4fc8-d9de-08d9af1f0ad8
x-ms-traffictypediagnostic: TYAPR01MB4317:
x-microsoft-antispam-prvs: 
 <TYAPR01MB4317B4AEED015059D27EEEF192619@TYAPR01MB4317.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4125;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 OWR7TSXZC0kmp4bQf0BbnDsDbn69JObUrE5YZz1TxynLYAUhwTO0ACKqVufTNg3lhO8jnPE5ljtKfwDuHficU7ptO2+fZqr8Fpave1FtDRs9EteBEz7HDNclkCk+mlaKgXY9jHchDGso1rL8U468c0zhtq1xw8n2WqKFgX8130Yma+Sq6FMLJCmGvQTGEs/1dArijqyfMvgApPAO1Y7sVTH9t2RsBTLsdhK/Yy9pWKB98Z3jVT+2dCRugdl+I8MyZpdr6lfLkFcw14I0GzwNlVTvfvip5P2FhtG/l8ARqkHkrxFJ9HaV49cVpLnq3qL1VV38Hu37eXlGAn7zXvAL1Ai/RofKRvYNEz8e9rwAU3xXCbOD5BpLAMW+OQVDQTLyAFwxS5yOjI4kg5lldHoayn4doFFR+yepdggY9+EcROKkMmCgWVSAJwD1OVP6EW6v7G0ScS2lblAKUIp2HGpGh5/GMPaLWfYD0keGmlLbRmlOzLYDivy8cfWUqBAy6tcu/+sSyzxcWi+gJQyzZNhmiOnYf318G2HCRhhWptpVx1lEvk0CnZvxkNaV//O5ZZDsYRbWy7vZjOf2zsFmRTmwVsIUHsSyPEoYjqqLRzWlLlzxwgfQETs6+vucLTAO6B73lTO69d8fHYMo4fi7S2WfJ8nCCSu3TylepK0utkIQaNrVT3qDRaXu19yy0Kni/3GhQkQokRWy8V/7oPnQFSn+tg==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYAPR01MB6252.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(316002)(122000001)(64756008)(66446008)(86362001)(53546011)(33656002)(8936002)(38070700005)(66946007)(66476007)(6506007)(2906002)(186003)(55016003)(26005)(83380400001)(508600001)(5660300002)(66556008)(8676002)(52536014)(38100700002)(9686003)(76116006)(110136005)(7696005)(71200400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?NGg3eVVsMzk2dVhCZUZONTlJSElMeVpmc0FQL24vQ1V1ZFk0RGsxTndY?=
 =?iso-2022-jp?B?QlVTeG53TkVmc2hlYjVhTzVKOXNwUjdmenVDN3Z3N0lxaTZDLzBxNVlW?=
 =?iso-2022-jp?B?VSs5U1NZMzNKd0w1SmMyODJhb0x0aU1ON0pKRmRpaUF4UmVZV0o1M2cz?=
 =?iso-2022-jp?B?SWxoU0ZQcXpWRms5c2wzWXl5aFV2UE1wbTBUTmdLd0VTb2NKOUhOUFJ4?=
 =?iso-2022-jp?B?UnJPem0rV1hKei93NmpDdFlEV2hvVUl1WnZXLy83YWExK1RYLzlHT2Zu?=
 =?iso-2022-jp?B?bk5uTHArZ0hJeU55K3JlZytTMERFV1FwbXhTZlFEdWhHbFpRb2J5Vmcw?=
 =?iso-2022-jp?B?SWxoTVJuMVBHak5OVm8xejVCdFNmdGU1emlZZEoxbjZBSkFNMnFxNnJt?=
 =?iso-2022-jp?B?M1YrUmoweVlVSGZkMUF4d3J3am9UcFhXelBQdzIxRnM4eU9kTndibkJw?=
 =?iso-2022-jp?B?VkpRNzZEeW8xek05YUZGRUtvVldVcVZSaFNLajNpRGhyczFQb2duYWtW?=
 =?iso-2022-jp?B?NWowbHNFTGZSOHpjbmxPbkxIa0o5SVRZZEZablRKZnV4K1FNTU55MHJU?=
 =?iso-2022-jp?B?b2pWdHl4bDNmNHYxMFB3SkQ5QWRiY1hCOWExYlVCK1pJSzRjUmoxUW9v?=
 =?iso-2022-jp?B?cUJaR2RYU2RJWlJ2V3h6UHRjNHRQSXZudzY5RlJvQmhWTU16Mm9nUFdS?=
 =?iso-2022-jp?B?Zzh1WGFvMWw0NnZBdGtQZmFNRFpLSVI0bFkzOWcrVVdSWlJaZFdzTU9j?=
 =?iso-2022-jp?B?VWVaN2xNbCtySWs0UWg1MDllM2QwZjZMcmlteFVUWGpFSWh2UUsrNFhQ?=
 =?iso-2022-jp?B?aFM5aEZlOHNKY3dBTTRwTGFSbmJRZVplVmkvdnhMNFRzMWl3OUhPUDlo?=
 =?iso-2022-jp?B?b1R4T1Q1Q3pEcGJzVDdhRkZtNTQ2OGdIYlhpU3Y5ZnpUZitDN1MwbEI3?=
 =?iso-2022-jp?B?VUR0NThocGVQUUlOdEI1UU90WHhXUGFPL295dzkxUHp5bGphOVZzbHdP?=
 =?iso-2022-jp?B?dEI2MTFyS0piTC9aNGNPWVNyMW9sZjJPSWdYS2FHb094WjBIYW04MTVB?=
 =?iso-2022-jp?B?VW9nc0xMbU9kaERDOWk2elcvVmFYQlNveE1zcmlXUE0rWVEraG5HZ0s5?=
 =?iso-2022-jp?B?ekE5cVdEQWQ5RFVvQyt1dTV5WWIrZlR0Yisxa2tNZW1oYWtDa1QyeUJi?=
 =?iso-2022-jp?B?T1g4QVNWQ1JlMzVCbDJ4SFNXQjdMS2FyM1luZmFXKzJXalZ1UHNhT3ZE?=
 =?iso-2022-jp?B?cVI4UU9rZ0dNS0pVZDArY21ZK1hLem5OUStFWS84UmlSQXArLzc4Zk05?=
 =?iso-2022-jp?B?STR3L0VXZWpSdWJHSWI5c01xZWQzVTk4KzBScUx0MHdmczlWd1RwMGFq?=
 =?iso-2022-jp?B?cEVBem1qTnA1NnRCb28rSUR4Ri81OWFQRENsY3JsaFpQUXdXdUZ1bXBC?=
 =?iso-2022-jp?B?WDF6Mk51V0FQelQxTURqT2xkZTZ3Z003NkRlZEJMTDdwTnhnc1lzd000?=
 =?iso-2022-jp?B?aWpsZ3pCbHMyeEFGNVpjTUR0MnRWSjhaUy9vZzNvK29Ma3hDWjlDVito?=
 =?iso-2022-jp?B?RDR1YXozTnYvSTNBSERycGtncTZwYjF6MVR6QXZpK05aUVpzYW9PcjZp?=
 =?iso-2022-jp?B?eTdBaWU3V1BTa1dqS25aL3N3NStUaStVTEdlUGdVTjdMVmYxSlpRMmxx?=
 =?iso-2022-jp?B?ZDRPNE13UkNrT1NwSmIyS3pFWERkeFA2b2E2WFlmZjJzb0ttTi9TZEZZ?=
 =?iso-2022-jp?B?bXdCczg3MHVRdzQxSjJKV3B5T2phcG5XY2FpR1pxVnBZeElxeWR4SHQ2?=
 =?iso-2022-jp?B?MGtmaHlZWUVqNUdldmFJOHlVVGl1VzZBVnllWnNrc1pKV0JmODM0VHZW?=
 =?iso-2022-jp?B?bEhWa1lMR0k4M3YxbXdhZ3FILzA5cEd6ck93SmJCZGo3NW1uT2NFbkJn?=
 =?iso-2022-jp?B?VzBDaityYUkzNXFjbW52UGE4eUpyQkp1Y3RicVloQ1RqU2pEUEpNdTJh?=
 =?iso-2022-jp?B?a25RQXRNSHlUYUV1Tlo2R0txUmVZMmxkVzhab2RVSGdTT2dVTmU3Nk0r?=
 =?iso-2022-jp?B?bDFZc1NGZVBPaFBtVTFZNUhXWUI1eW12L0N0ZjEwOVFZU2grclYrMHNH?=
 =?iso-2022-jp?B?NG5mdFltRzF0akk3MTRpbFVxSDVHaDdWKzYrMmR3Q3F1blBQeStYWXgr?=
 =?iso-2022-jp?B?WVdDY3JZU25RVmFsT2NlWFN2UUVXenpDM0hUc0xIQ3BETEFpZEJPcVgv?=
 =?iso-2022-jp?B?RHluNmhPSkhNMFBSMG8zZXliN05Nd2JKQjZSRXp4aC80MTA4Ynk5UFpN?=
 =?iso-2022-jp?B?ZzlzenNQVVZITW50TjZVbHRDQ2hIMHN1RG5wbFU3KzlEYzRPaHNsdDhi?=
 =?iso-2022-jp?B?SGZLeEFoaEttUzl0QWdaREdwSWJyMm1uOGRnYXA1NDZ6TEtqVGp3WVhx?=
 =?iso-2022-jp?B?OVQ2TDZET2dpMU00OVF6SmJvQTlPWmdNNE9zRTkwem91bVR1bzAxcjBN?=
 =?iso-2022-jp?B?THpTSGxK?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYAPR01MB6252.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 791fe5f6-fa4b-4fc8-d9de-08d9af1f0ad8
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Nov 2021 07:50:10.9331
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 
 q3s6eTm0X5VMHZLhGlA54fkk/oa8Z8vEI3vBBuZOFU0WzrJHNswoaJPe1tdKs5qbz4p7bRRaqbbvLZsBA2e2SW4MthmlBMu/p9p8fpQk+Ue57KvPSoNwCXgoSQqGu4P+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB4317
X-OriginatorOrg: toshiba.co.jp
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 24 Nov 2021 07:50:22 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/6986

Hi,=0A=
=0A=
> > Add the necessary kernel options for a read-only rootfs with=0A=
> > dm-verity, secure-boot and swupdate + overlay of /etc.=0A=
> >=0A=
> > Quirin Gylstorff (2):=0A=
> >   x86/cip_qemu_defconfig: Add options for read-only rootfs=0A=
> >   x86/siemens_ipc227e_defconfig: Add options for read-only rootfs=0A=
> >=0A=
> >  4.19.y-cip/x86/cip_qemu_defconfig        | 4 ++++=0A=
> >  4.19.y-cip/x86/siemens_ipc227e_defconfig | 5 ++++-=0A=
> >  5.10.y-cip/x86/cip_qemu_defconfig        | 4 ++++=0A=
> >  5.10.y-cip/x86/siemens_ipc227e_defconfig | 5 ++++-=0A=
> >  4 files changed, 16 insertions(+), 2 deletions(-)=0A=
> >=0A=
> =0A=
> Ping. Are merge requests preferred for this?=0A=
> =0A=
=0A=
Sorry, reply was too late.=0A=
I reviewed this patch,  applied.=0A=
=0A=
Best regards,=0A=
  Nobuhiro=0A=
________________________________________=0A=
=1B$B:9=3DP?M=1B(B: Jan Kiszka <jan.kiszka@siemens.com>=0A=
=1B$BAw?.F|;~=1B(B: 2021=1B$BG/=1B(B11=1B$B7n=1B(B24=1B$BF|=1B(B 16:36=0A=
=1B$B08@h=1B(B: Q. Gylstorff; cip-dev@lists.cip-project.org; iwamatsu nobuh=
iro(=1B$B4d>>=1B(B =1B$B?.MN=1B(B =1B$B""#S#W#C"~#A#C#T=1B(B)=0A=
=1B$B7oL>=1B(B: Re: [cip-dev][cip-kernel-config][PATCH 0/2] Add options for=
 read-only rootfs=0A=
=0A=
On 12.11.21 17:38, Q. Gylstorff wrote:=0A=
> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>=0A=
>=0A=
> Add the necessary kernel options for a read-only rootfs with=0A=
> dm-verity, secure-boot and swupdate + overlay of /etc.=0A=
>=0A=
> Quirin Gylstorff (2):=0A=
>   x86/cip_qemu_defconfig: Add options for read-only rootfs=0A=
>   x86/siemens_ipc227e_defconfig: Add options for read-only rootfs=0A=
>=0A=
>  4.19.y-cip/x86/cip_qemu_defconfig        | 4 ++++=0A=
>  4.19.y-cip/x86/siemens_ipc227e_defconfig | 5 ++++-=0A=
>  5.10.y-cip/x86/cip_qemu_defconfig        | 4 ++++=0A=
>  5.10.y-cip/x86/siemens_ipc227e_defconfig | 5 ++++-=0A=
>  4 files changed, 16 insertions(+), 2 deletions(-)=0A=
>=0A=
=0A=
Ping. Are merge requests preferred for this?=0A=
=0A=
Jan=0A=
=0A=
--=0A=
Siemens AG, T RDA IOT=0A=
Corporate Competence Center Embedded Linux=0A=


