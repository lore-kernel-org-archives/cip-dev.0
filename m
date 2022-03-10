Return-Path: <nobuhiro1.iwamatsu@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C25BC433EF
	for <webhook@archiver.kernel.org>; Thu, 10 Mar 2022 12:43:11 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.157])
 by mx.groups.io with SMTP id smtpd.web08.8945.1646916189180377252
 for <cip-dev@lists.cip-project.org>;
 Thu, 10 Mar 2022 04:43:10 -0800
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: toshiba.co.jp, ip: 210.130.202.157, mailfrom: nobuhiro1.iwamatsu@toshiba.co.jp)
Received: by mo-csw.securemx.jp (mx-mo-csw1115) id 22ACh61v001920;
 Thu, 10 Mar 2022 21:43:06 +0900
X-Iguazu-Qid: 2wGr5ydFQr9G8DxWGf
X-Iguazu-QSIG: v=2; s=0; t=1646916186; q=2wGr5ydFQr9G8DxWGf;
 m=+1mdgbFKU+6uv/pTQDHDCa4wwd5faACRwRTKg8ZvZZE=
Received: from imx12-a.toshiba.co.jp (imx12-a.toshiba.co.jp [61.202.160.135])
	by relay.securemx.jp (mx-mr1110) id 22ACh49I004002
	(version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Thu, 10 Mar 2022 21:43:05 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ImrkBZJCldV9X74YBB0+yzvcg6vgLd7FK9QtkH2NFpdgCtrLlgKFcxZsg9lnmHN0KW+mWOv9frNnOFDDKXrQl2/+AuOC0aaIYKWdEh6avNzbBoJBpUQ7M3XA2YapL5lQq82dvQARgeMAeTM6F0mm5ZZSe8TDFUUZBaVv0xMRaEuZe0Gyia5fe5wtOPQhvD1peiDiBUJqwdyG6WDhlGh4WIvOgMlPMqG/P6U8QuzvjaLZovjY5pquKFyXVq5j1qa2s/uWepNc2EXRqv0txGnc4bgS7AX5liJtP/kS7eYlKIjZF9qvomqNLOXmpZz6N0es1DrzlhqEUqXDxWdqS7OT3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/xcyW/VLds2vZbPOYz6o4aJEpc9D0kV25HopQXOW+dE=;
 b=UGiZ53ykZxwENFhGrsIadEA5P8hudF8UkkjrIIGNMqnLarsWwAvEj/OHo4Lcuk44b1xEOCN3bGqgK66wIPHjbPC/yLfq3HZ4Ejzp04XJ548DKk3xLxWmrzmvaoLE8eZZbSDYoFfI3rw/rntXipoWGvoMKFemtm1cE0BzKkbo9/PO3ade+SSRKNNQEOnNLpjVa6Fp5No68VHce1svhtwAHNQnJ5gvhwAEuVHHdllHNi7tJfoHiTf9u9zKwdHwxWjab0Gjaj8W+XXPGFn+fRwQ8Ylql26OKc5ngKIgNWHbdXM3HIKdyRyeSk2afWpnWMtS/Xa0tEylzGuYcfzVXm9xJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <Chris.Paterson2@renesas.com>
CC: <cip-dev@lists.cip-project.org>
Subject: RE: Adding v4.9.y-rc testing support
Thread-Topic: Adding v4.9.y-rc testing support
Thread-Index: Adgy+xq6CQjO4FHnRhabwhOca814qgBgOr4w
Date: Thu, 10 Mar 2022 12:43:02 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TYAPR01MB625263A117252890F97F6B0D920B9@TYAPR01MB6252.jpnprd01.prod.outlook.com>
References: 
 <OSZPR01MB68776F5E350C51B188876E3DB7099@OSZPR01MB6877.jpnprd01.prod.outlook.com>
In-Reply-To: 
 <OSZPR01MB68776F5E350C51B188876E3DB7099@OSZPR01MB6877.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 545bd1d9-5c41-4eaf-1dbf-08da02938416
x-ms-traffictypediagnostic: OSBPR01MB5286:EE_
x-microsoft-antispam-prvs: 
 <OSBPR01MB528697C9DDC4D38ED17EEDD2920B9@OSBPR01MB5286.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 qr8hTxaBIfNQFuFp2Z5IBu5VLaoQVN4IFHZxRhAN80uFVUDCDpykrXX9toHgeTZiX2aVzZyhlgxNq+cC9Ov/GRDVLNB1fOLDCJmtQhAtC4ipdB0dPcX7PkOntqHXxr6iQBUfMRYDj6yC3Rnxziw9wbQJFUyouxdpBKc6+xdrtH+II+49HV4Fdud5ycaFNwm4c233ollw/EWdZR4UV9QGztnW8ZibHzJiPpyXEZQzK3IJMLwqXSWVQQmrH7xxsAE207CN38YBdBwS3NTMBGELBocsa6HQ7efdmAusDHUVM3kG/z1MBKamPKyfl+bLPUsGbP+ct4lNe6Y33NxyR/Yb9Z8+h2LC/ldQ+tjzBm4WToRyLJ86gqll3X+GuZmEDVCOB7TiDjfiqwWcsBsL61DlVu70ZrmzGRgrJuOogzwxoPhzLHly0EF1AQdsS8aclk/WnBMHFqw9IOYIGJ/+o/uFlJBCWBlktKhOtAmeFPN0M2IBhOKXCghHIByaEIQCRiRYbWXFv38780lXApiLH+2pJP3RCWyl/IutueBib4AYgkF5SqCWtx9j0jmd3bYkYSkBJpnJLKGtv0N8EYmmj73bNI4rzfEh19XyBiNiPgjgrytCg1Jp3PZMlqTozZJUQmOs0Q5oclfxAO+/YUPJjZNG85bKJhUyY0bfxqkt8Buym+O2300s9ZrQPPpMjWSF2ZJTZDuSv2ssBzdPph8BiwLpOaAudPbCW/Eapxvpb5GhHI38rDWb/7jThIpOOa0M8/LTj1Xdw1mo+isRY57Y1DmCZKxLxOtu2j7zrRgXACeUp+oUIz+zmKXKhzDAxyXssOcBFw6XZ35C639WSZtvhFRpoA==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYAPR01MB6252.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(71200400001)(26005)(8676002)(33656002)(6506007)(186003)(55236004)(55016003)(9686003)(7696005)(53546011)(966005)(66946007)(6916009)(508600001)(38100700002)(122000001)(38070700005)(316002)(83380400001)(86362001)(52536014)(4326008)(5660300002)(8936002)(2906002)(66556008)(66476007)(64756008)(66446008)(76116006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?d2JYVGUxM2U0S0NEaFEyOVZDck8xVlR1RkVvSXBRYlBDK1FYR0h2dGo3?=
 =?iso-2022-jp?B?NFBydktqVks1L1lFY0E0NTlRY0UyVUhWRm5PMDFyVnV4b3RBcWJJSXZy?=
 =?iso-2022-jp?B?YzhKdUxPUGlWU3hFK2svN1R1dXg1djV6R1lPakgyQjB3OElEdm1FOXF2?=
 =?iso-2022-jp?B?TUZ6Ly9sRTVaQk40M01NK00rU1F0OTdMZjJFMUdUWGNxTDJLRGErTVQx?=
 =?iso-2022-jp?B?WDkrVTZHUVY1NVN0S3RaTXNGL0FlRkJRR0xFcW1rZWVLTW12Y0sxb0tJ?=
 =?iso-2022-jp?B?eEtMWk5HNXJwTmx2cm0ydDIxc0R1VVZ6Njk0OHBCYU9mdG5qU0E3NmhD?=
 =?iso-2022-jp?B?aXlrWXR3RnpRRzBlKzJBNzZ2RW4yZVNpZzZFL2FZQUpIM3AzTDlUcGh5?=
 =?iso-2022-jp?B?WHFXYTIrZFY5TExSV2ZrcVVwb0FlWXQ2MGlWYk1hc2VUOTRzYlY1Ym5m?=
 =?iso-2022-jp?B?a0loNFRnYVRYNjJuc24wT2lzOVdrL3JCOW1jZk9LZUVVbFBULy9iNmJZ?=
 =?iso-2022-jp?B?T1FpUXNpejV6RjVobXFQWEVKa1FDeFd2WUQzV2VETDBSc1dZQWljQldN?=
 =?iso-2022-jp?B?VmZLNzIrdTNXL0lobzVTYjNxSnVSd0FLVGo1VC9WYkNPNVRpTHFhSkVp?=
 =?iso-2022-jp?B?ZUt0OGtVZExXNUVYTDlFQUEyY09JVkVuM29Iamp6RGRQTVNBZUZjcDc3?=
 =?iso-2022-jp?B?TFZSRmpXYnc3bkRtMEFRMUU1Q2NKVjhuTXVSdGxxdnVlWEdBcU94enor?=
 =?iso-2022-jp?B?UCtsZURybzJJazhKY2dNNW9WaWhzSjEwWXBiQnhpdDY1aUVDMTR3YU9N?=
 =?iso-2022-jp?B?NjRPdXpyNlNqSmwzOWVGVGVpTHlCaFRQc0lnc3NpOXpiejVlcTc2cTdR?=
 =?iso-2022-jp?B?ZlI0V3h0R0xXMmlMZ0h3cEZROHhlSDV0OWdweUhEUUlRMnVhZlZUeU1V?=
 =?iso-2022-jp?B?dktVYkNDRURMdzVlWHhoL0cvSzNyY0tEYncrNGpwZjFCcDZUb01rWHFQ?=
 =?iso-2022-jp?B?VHBjdG9zTlBhN1UweElXNmlHM2RmSCtNakRWUnVFSEN1RkF5c0V4Ykpa?=
 =?iso-2022-jp?B?TmUvYVR2eFJ5anhBcCtWRFVDRWtOWE1ML1cxcSsrQnErR3RjU29tdVFH?=
 =?iso-2022-jp?B?anJVbE5uYmo1WE9BME1CYUU2bVlGMjd4WGVaU0RSZ0Rtdkx4N3BIcmNN?=
 =?iso-2022-jp?B?ekxmdU5QRHptWmVIbFNsbk1maFdUMlNIeFJuNEMyVUFnMkpITG9qTlUy?=
 =?iso-2022-jp?B?QXV1ZjNNdVpoZUhOWDZWM1Z2S3N6dFdOWlR5YnJEZGxaNzhNTittNDRV?=
 =?iso-2022-jp?B?QmN5YUZQWTlGUEZnZE5Tcyt2N2QvZjZvT25ER3ZiUHZTR2dhbFZ1THVh?=
 =?iso-2022-jp?B?QTkrb25lcndxa2k4eWloTm1mVm5lLzBwM1pEcG5kWCt5UXl3SWFrY3Ax?=
 =?iso-2022-jp?B?L1E2TEdYRmx3Ynd2V2R0Qm91eG85Vk5JanRMQTBsa2ZKeFZsNmRKS2xP?=
 =?iso-2022-jp?B?OXRWNkNIVDBaTjNta3ZBeTNpdFlKWjl2UWZmN2c0dTVJcGJIZm9ob0ta?=
 =?iso-2022-jp?B?b3QrUnhEMDllRFdKemYyMVk4YTVmbkhMck83MFpHc0xYYzB0a0FvbFgw?=
 =?iso-2022-jp?B?Q3BWd2NrQW1jQ3ZxOGJib3AydVhCYTQ3LzVXZHRIZDcxSjB6VEJVYU9V?=
 =?iso-2022-jp?B?cWg2KzY2YlRvRW1nRmgwWTRmWjQzVzNEaUs5dllMK1krU05PQTJvSE9h?=
 =?iso-2022-jp?B?RGZOTTI4b3RGamZ0ajI4a0MxOFcrbGdnbTFYNC9vcWlDcW5ORWp0SXJE?=
 =?iso-2022-jp?B?SW1CdG15Uy8rSFRhRkw0UDZVTndXdmMxdGgyd2lGaVdGSjI2UnU0WGp5?=
 =?iso-2022-jp?B?VjNzb29OZnlhVE5qL1prOVI0Z2k5ek9EVXMxelZpTnBCN3Z6c0U1N2dM?=
 =?iso-2022-jp?B?dC9LMEp1R0ducXI5bHJ1QTRqaGJ4UU05UHVVcnliNE5GWlJIY2NXN2h6?=
 =?iso-2022-jp?B?bUJNNW9oOUlKOTVoSnA3ZDJsK29TMXU0QjlzeTVvV1pRYklnTUdGcG5n?=
 =?iso-2022-jp?B?ajRXUms3R2dUZ2Zsam9SL1lzREh2ZHJhZURyNTZPcmI0Zi95RlVLdUo1?=
 =?iso-2022-jp?B?SldEYW1pMC9zT1poSitmcDlobnRtVDJ5VVVlbVhQNE0wSTJONXJaUTFl?=
 =?iso-2022-jp?B?SUVwNkE5anV6bTVKN2l0RDRXSERPTGsvRlVOdnVrc3U2YnE2L3o0Z2JN?=
 =?iso-2022-jp?B?Z3JKeGJiY3FJYUx4Z2JxMVFONzk4eVVQUGJyaStEZkdneGNoNTBzcXFC?=
 =?iso-2022-jp?B?RGRYQXloU0lPN0xHWGVhVXZsNk5FK0xBMDRqcEpBMDVTQytTQmUvN2E1?=
 =?iso-2022-jp?B?NHoxUjRhMW9aZWk1NHdZSXFPODNvMDIzT1JWWXlQYTFHR2s0WndNYmNz?=
 =?iso-2022-jp?B?Y2VVQSt5THNLMUl0S2lra2Z0elRrSE9qK2p2WlJNbkdpRi9GWHhIWXpX?=
 =?iso-2022-jp?B?UGZxbkU2?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYAPR01MB6252.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 545bd1d9-5c41-4eaf-1dbf-08da02938416
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Mar 2022 12:43:02.5211
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 
 9rmU1rw51iJfS4+UvHJ/43X9bc22pn0ULiL0dwpDTxuESyKAIcheCEh4owIu3jiWLYwWJ45FLkVTRmM/fjThMg+B/2TwSsjOFiEwlfH8/8n8Z3JIzYahnO01pM/oiAw1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSBPR01MB5286
X-OriginatorOrg: toshiba.co.jp
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 10 Mar 2022 12:43:11 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7688

Hi Chris,

> Was this intentional? Or do we need to reinclude the siemens_am57xx-pxm3,
> siemens_dcu2 and siemens_iot2000 configs in v4.9.y-cip?

I apologize for this. The .config was filtered by gitignore and was therefo=
re excluded from commits.
I added these and committed.

Thank you for letting me know.

Best regards,
  Nobuhiro

> -----Original Message-----
> From: Chris Paterson <Chris.Paterson2@renesas.com>
> Sent: Tuesday, March 8, 2022 11:54 PM
> To: iwamatsu nobuhiro(=1B$B4d>>=1B(B =1B$B?.MN=1B(B =1B$B""#S#W#C"~#A#C#T=
=1B(B)
> <nobuhiro1.iwamatsu@toshiba.co.jp>
> Cc: cip-dev@lists.cip-project.org
> Subject: Adding v4.9.y-rc testing support
>=20
> Hello Iwamatsu-san, all,
>=20
> I've started to add v4.9.y-rc testing support.
> Initially the build/test support [0] is identical to our v4.4.y-rc testin=
g [1].
>=20
> In a test run [2] however, we're seeing three failures.
> Looking into it further, it looks like we didn't copy three configuration=
s from
> v4.4.y-cip to v4.9.y-cip [3].
> Was this intentional? Or do we need to reinclude the siemens_am57xx-pxm3,
> siemens_dcu2 and siemens_iot2000 configs in v4.9.y-cip?
>=20
> [0]
> https://gitlab.com/cip-project/cip-testing/linux-cip-pipelines/-/blob/pat=
ers
> onc/test-4.9-stable/trees/linux-4.9.y.yml
> [1]
> https://gitlab.com/cip-project/cip-testing/linux-cip-pipelines/-/blob/mas=
ter
> /trees/linux-4.4.y.yml
> [2]
> https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-/pipelines=
/486
> 998446
> [3]
> https://gitlab.com/cip-project/cip-kernel/cip-kernel-config/-/commit/e737=
c
> 5ec22d2b7d3220d83855a952340f2357636
>=20
> Thanks, Chris


