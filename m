Return-Path: <nobuhiro1.iwamatsu@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1705DC5B549
	for <webhook@archiver.kernel.org>; Wed,  4 Jun 2025 23:11:27 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.132])
 by mx.groups.io with SMTP id smtpd.web10.31121.1749078679826153644
 for <cip-dev@lists.cip-project.org>;
 Wed, 04 Jun 2025 16:11:21 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro1.iwamatsu@toshiba.co.jp header.s=key1.smx header.b=RNTnlp/q;
 spf=pass (domain: toshiba.co.jp, ip: 210.130.202.132, mailfrom: nobuhiro1.iwamatsu@toshiba.co.jp)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=toshiba.co.jp;h=From:To:CC
	:Subject:Date:Message-ID:References:In-Reply-To:Content-Type:
	Content-Transfer-Encoding:MIME-Version;i=nobuhiro1.iwamatsu@toshiba.co.jp;s=
	key1.smx;t=1749078667;x=1750288267;bh=+MkW4K4/MiKAPoMMw4UCJYsiPECSJ2jZE1izggP
	ndRo=;b=RNTnlp/qTjba3SigCMMIikyXYwnbjC6/b0M1bggc6krDJc1G+74b+hTk2Aj+hLekmPkZC
	fEJrifVITF/zypvaQdi6D3tpLoprDEZcdZQYxpVIbDkcK2TPD6e//Deux2MGntNep3pMuQt/5CMFO
	D8TsLNL7Bk1RSSn7zv7RHnODM8oM7EnEtmvrq8GfjnuiDlc7iHxyhUpQj5oXR+CvntFIM+Kb79g5u
	HeaW9eRrjkggxtMUpRd26bR7/BNuoZWQOiY6aVRfMjTWPK8hqUW//kkFvOKT8mPtVatti3HNjVxsr
	HiRJ+RwLEUoo17krrULyQvoRANeCUNFmjJWmR3wGZQ==;
Received: by mo-csw.securemx.jp (mx-mo-csw1121) id 554NB6TV2503858; Thu, 5 Jun 2025 08:11:06 +0900
X-Iguazu-Qid: 2rWhqikyfwNNw2Yh9N
X-Iguazu-QSIG: v=2; s=0; t=1749078666; q=2rWhqikyfwNNw2Yh9N; m=LCk/CUfkDcsK6gTQf8t3Aso4dKUqGmcIF4bEfqmEDFo=
Received: from imx12-a.toshiba.co.jp ([38.106.60.135])
	by relay.securemx.jp (mx-mr1122) id 554NB4Wi366952
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 5 Jun 2025 08:11:04 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XcB/duwchQWmWxo+BC+C49RTnMzK+50mjC1RvHguAD/gsaQcD5J6TNxlE8OvoXxhOJzDGVEru2DtEA9IIGukSw7uTKxHdnpKC4oStjN45Qu31aWUjIal6tiO96xWZmfoSAynzB2nSsWnbFaMGN8U3BJLNKIsAmVzbetcSbei2Z1e/UjcYLDxxsj6byV3um0lLtSiu7El3YmdFAai2rJM2OOrWhO2XtFx3S9oMagx8wqUuqocr4rG7zPtBh/p0Me5EvfTwWStNZGz8vqwIFhXQQOoetXjNaqwUyRq1WCw+oj1fnjPdgh2fXQNMGPTTBvccmoiWk1CywM0T8ma1Te5VA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zx8qrs0HksoydPnmOgBY4OmG5WJNaJFbmHxpaL0g6a4=;
 b=UIZ9kyAYq3duJSWqQdsSfndrJNYjecDWPAoOj2Jp56mfJ+BdTn2OSUv2n4Jq8WsK5hO/rUrH/ylZsVbJC5bbqMOTRXjDpgXnnOV+opLGwDOP/qIW57nho+AwccY6jeIhnPTI7Qiujf+n8wkJA2dYPv+M3aaxsDgKIa8f8L+CUN4Bt7+iEGbblfISH4UcGMThvZeZL1DTB8njOor706Aiu6Z6rkscx+aq5ncBcJaEb/4oSDZlStY6FQw5UWPr5Z87GlSYUOmo/1Y/8luuNuOsWcX0hC83F3ZvQw2Qhi+EQ7AXhgX9DNXx1C7Yr2q6risPJeQ7cucf6HfILcMwzBSqdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <pavel@denx.de>
CC: <claudiu.beznea@tuxon.dev>, <cip-dev@lists.cip-project.org>
Subject: RE: [cip-dev] [PATCH 5.10.y-cip 0/8] RZ/G3S: Backport SCIF support
Thread-Topic: [cip-dev] [PATCH 5.10.y-cip 0/8] RZ/G3S: Backport SCIF support
Thread-Index: AQHb1GiVraiTMyrAD0KDMzF3YZz7aLPygocQgADjeYCAADvu4A==
Date: Wed, 4 Jun 2025 23:11:02 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TY7PR01MB14818CED682D83FFDB9849B33926CA@TY7PR01MB14818.jpnprd01.prod.outlook.com>
References: <20250603091903.3917202-1-claudiu.beznea.uj@bp.renesas.com>
 <TY7PR01MB14818FD9A1E03EE9BF60F7EF1926CA@TY7PR01MB14818.jpnprd01.prod.outlook.com>
 <aECfTblonQThFl+1@duo.ucw.cz>
In-Reply-To: <aECfTblonQThFl+1@duo.ucw.cz>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY7PR01MB14818:EE_|TYYPR01MB12960:EE_
x-ms-office365-filtering-correlation-id: 73f68671-4805-47d4-d06d-08dda3bd1372
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: 
 =?iso-2022-jp?B?aHFrL1F2YjRvYXh1OVFMdnI5RTkwbjB3Q1dEZy91S3R5REJWZ0V3UDVG?=
 =?iso-2022-jp?B?V0MxUEd4NkJjTUNkNSt2VS90RlVsZGpOUGVhWCs0MU9CY2hGS0tWeWl0?=
 =?iso-2022-jp?B?RXdjRWV4QWU4WklPTER6RW8rWnpTNm85VXkwUW1xa0o4ZllkakhPVXhD?=
 =?iso-2022-jp?B?cCtlcWpKYVNFK29mSnJpNjF4SnR5MmpGRlRXQ3Y5ZmVBcGROeWFtTE5H?=
 =?iso-2022-jp?B?RktTQlFQb1JZNncybngySmxBNnBHTC9JbTcvOVBzWmJpN1owN2FWMDRK?=
 =?iso-2022-jp?B?Vm1MOVdpTTlJQTQ5QXI1dU1tbXlBRHVZL0hIS1h6MnVBSEV3b21rRzVW?=
 =?iso-2022-jp?B?dXg0ZVpJVW9VcytZNWtOTVN3L1JqNkdyRUdRZFM0ODI1ZGQ5QnlQTEND?=
 =?iso-2022-jp?B?OUFuVEdLSWZrS3JNM2FhUjhWN1hpb2VobVh2REZmVTZhYlhpOGpCUk5v?=
 =?iso-2022-jp?B?UmdzYkRkeDZDd3d6ZjZyQ0xqUkxla1hFdkJWSkpTa1ZuUVZERzF3V2hy?=
 =?iso-2022-jp?B?SlM0aWpaNnB3cmplbThYSlJ4QUJCNEt5cFFHQ3RkREFXL3NBNlJvMi9G?=
 =?iso-2022-jp?B?eHAzTTJkR3hNQW9qNzB3YUJwVlg3dXR0ZUpOK0pYR3M3WGM4RHZ5NWRR?=
 =?iso-2022-jp?B?aHR5Y0w5eGg5aVFCTVlMS29lSFFUSVdVMEppNWFOa3ZJeFlBbnpVeVVM?=
 =?iso-2022-jp?B?N05GcWlkajNFZE1Zd2QzMEpra1lnU0JWbitLS20welFEVmZvWGh5eVlq?=
 =?iso-2022-jp?B?R1V2Y1RFWWxCTHFYK0dIZExYUTRqN3AzSi9Bc25VZFV2ZkZxR3lSeldP?=
 =?iso-2022-jp?B?QzMwblhFc2VsTCs5QTkwZzJpYmN4dVlYNkY0R2tQY2hpcGdoNDBuTzN1?=
 =?iso-2022-jp?B?R3RWb0JqOXoyNFRQQWFNZWNDS1N1U2FTZTFWcHA2QmFCVEd3ZGxUUDh6?=
 =?iso-2022-jp?B?R29TUWpTbjJFOHNDTTJJTTZsQ3NKcGZMeldLOVNZdmJjVVVRbGF1Yzdv?=
 =?iso-2022-jp?B?ZmJWYkV2SkJRbW5BcmRqRVZLaWwwS3hjcUY0SVJROXFNYTdtNklOWVFy?=
 =?iso-2022-jp?B?U3lwaXRadnJlRzlvRHBSVklEeEJTdjVqbW1iWm9mNUJZYm1odGNJRHVp?=
 =?iso-2022-jp?B?WEFqL3M2MkJoU3ZWRDQ5ZnpQRGVIVEpWVmNvdTFEU2ZOSE9BWWlHVVBR?=
 =?iso-2022-jp?B?RXdFSDIybEpSb0pHOU80Y3g0c0lQeFVIZEw2TkhyS3RjQkhsekd1dG5E?=
 =?iso-2022-jp?B?cTI5L1VuUytxb1pUcG5hczE2RVdMS3hreXUwY2xSN3Fac1FaYkF2cG5P?=
 =?iso-2022-jp?B?OGVQajJLeEZINnNobWI0THpia3ZSL0pWbEgzTHErM2V0UlRSL1FCWmg1?=
 =?iso-2022-jp?B?ZVE4ZGxOcEdUKy9MZkVRcGRjaTEwSFV3bFRtajJNZHBGeTl5MEU5VFFl?=
 =?iso-2022-jp?B?MWpla3FyL2M3eTZra3QvYkVjem5tUlFDdnV0WTBnUUpCdzlQWHQvTGZK?=
 =?iso-2022-jp?B?d1Y1NUlCbE5ES3RMMTBJQXVHRXVBTDRmeitsWlZRTUtuSitzenVDUzlv?=
 =?iso-2022-jp?B?clFuZ0ZSNUZRRWF3cUExZzA3UGF4RUtDcHNTNkNydzdWVTlYbUZZUGpB?=
 =?iso-2022-jp?B?ajdLeG5uWVkvTEZkSHVhZzc5VlkvVmxCbzd6M2VIOVNSNlduSnExUVhw?=
 =?iso-2022-jp?B?UkRZRHlJeDVWbWM2eisxMEN0eGwydXJrZHBZWHF0VXhlYS9yR3F0eFc2?=
 =?iso-2022-jp?B?TjRmTXBsb3k3OXVEcFg0Tms0eTNuSG1Ca3JMYUo3alg5UTRWWHdwZGNY?=
 =?iso-2022-jp?B?ZjVWbW5oeTJEai9uYUd3ZnZxQStaVktZeWMrMkxzYm90a0hhU0JoYUtq?=
 =?iso-2022-jp?B?akFtMGFDNVpPUit5T3lUdW5aOUhOc0lTZ3NDR0NlcHYvZEduSjE4MUx5?=
 =?iso-2022-jp?B?dU1vUGZaSmE5SFJHcU1ObCtxQkc4aWtJcW82S1k3M1drLzlhbGVkdXpy?=
 =?iso-2022-jp?B?QzljSk14ZnJLRjdaQjlSUzFNSGd2WkxuUFhYK3ZnRTEvbVYyNmRlbUYw?=
 =?iso-2022-jp?B?aTlwT1NBeFZhaXNlZTBZN1Y1dUhQLzA9?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7PR01MB14818.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?NGFQNnczT3Z5MUk4R2Z3LzkwckNDay9wVjdIMlNhMXVYRXpnaXlGeHd1?=
 =?iso-2022-jp?B?dlhVdjhoMERLY1BXeGVJM0VHYkNIbXRzTmNJNWY4dlNDUUMvM1RQRjVq?=
 =?iso-2022-jp?B?V2xaS2poampxRFUyWXZLRzNLaTZZcFZvV3BtajFNMVI2eGpGekdmSCtO?=
 =?iso-2022-jp?B?TElMTnU5Tk5CdFN5YmQ5M2ZxTmVoM21kWkNMWnNiQ3BLRG5CWkFGOE9I?=
 =?iso-2022-jp?B?SERBZkRENWVPT3JBaUVlUTNoMGt5dGFZZDdDZHUzWlRlVkhwUGlXUURr?=
 =?iso-2022-jp?B?WDRYRE1Ob0pEZ0RKRklEOWlJcnVzdkkzSTZtenFVZnJWb0R4czRKcjlI?=
 =?iso-2022-jp?B?SVJVbE1LL2g2S3N1S0Voci9idGxmVUgwZ2g0a0ZheDJIT3puWlpmbGhO?=
 =?iso-2022-jp?B?V1gvS2VobDNpMkJ5VzlFVGE4VEplOVc3VUNhUW8vNk52NFNQM3BERWtH?=
 =?iso-2022-jp?B?eU53cDY2NmxOOXNOMGg3MUZaNXAzTGZXT05Ic3U1OUpnRHVERlR5VFo0?=
 =?iso-2022-jp?B?bVM1c2dtTVVKQ3VwZ1pmVkFKenVNWTQ3M0s0cmprK0hWdFNZQzQvVzk2?=
 =?iso-2022-jp?B?YUkzdFN4WHpKQjA2ZXBXNVRncFFrWkJJWm1NSFJDaEJxWE5wNW9aVFJZ?=
 =?iso-2022-jp?B?d0NxanliREpzZGp5TXFsOVVQTkFzMkErUG9pTmFPMDhhL2Y5dEFpQ1V6?=
 =?iso-2022-jp?B?QVRxaE5GSm1ibWlRNmlYdlBBS2Z6QmlrMExENnhTUXRkYWs3M0FseXRB?=
 =?iso-2022-jp?B?UzQ0STRxUjRZdTFiTWpwa2pQeGsvcVpsUTNTdXo0V0dKY3hiNmJkZkZK?=
 =?iso-2022-jp?B?dW5XcnhQdFYweVFiNVZ4aFlRdi9ZaDZDTm5qMkhONzZzWUNKd0ppTDFL?=
 =?iso-2022-jp?B?YzF3SGdGbnh4QmZBYS9ldis3R0JLOUxuaGN1c240UjZtUG5IRG9IWHBt?=
 =?iso-2022-jp?B?MWc4SS93MWF1MkJ5MU53R1N5NDVTRVNFdDcwQkZZYmo5MGlXTlYzOU1W?=
 =?iso-2022-jp?B?NkdGZ3FFa1I4NHk3NXVINFZBN29OODNwYXFncmpjenMyT21wVU9ISjFO?=
 =?iso-2022-jp?B?NFBQMkV2NVhTNTAxUGJOdGJneHdDbmVDQ2M1S2l1TDZhZGI4Y29WaVpN?=
 =?iso-2022-jp?B?eUFpd2pkZVBrb2g5VEljOVBaZ1o4bG94a3RMWHNCMFBQQ2dUb2pXSFRT?=
 =?iso-2022-jp?B?bFQ0VGU2Um94K2RVd2hBQW5OdjNwRlRObmk0TkZ6MFVQbWxJSERuR3k2?=
 =?iso-2022-jp?B?MFVsZWFQT2w5NnQyc0NUMWs1LzVYRUJTV00rdzBhSCtKWVNwekNHWUZ5?=
 =?iso-2022-jp?B?TzdFZ0VLY2RGTmtuVTZ1cEVuMHNza0RzOXlwVHcvNldSeWZuUGpmMnly?=
 =?iso-2022-jp?B?U2RjTWdwTEZiM2piZHUrN0FsbVhTdnBTa2g2Nk1TbzFQQ2JhbXNIZ05x?=
 =?iso-2022-jp?B?Ym9JWmdIeXlDTklpcEsvVy9uNVZoZXQ5YWI4RXNNZWdQc1pJTnlhN1E1?=
 =?iso-2022-jp?B?Zk5vZVg5SzVETEM2NWw0emE5Q1hwSFBiMlBCZDh0cVJKOTJrcWtCMFVD?=
 =?iso-2022-jp?B?SEFpaUxFS2ViMUV3dzhPZHVqUDBHTEp3MGd5U0laVmxqOVFEakJuckFR?=
 =?iso-2022-jp?B?ZUo0OE84UGY5TG1oZWhEN0g5eXJFZlVuZVdVM2M4b2NjWlk0cWhFb25G?=
 =?iso-2022-jp?B?ZUk1c2JudFBiZ05wdkRQdmtQTW9qWWlUZUMvVktnWG8rSU9MMEFJemIv?=
 =?iso-2022-jp?B?c0wrMjFhOXJ3bVhIaDJCZWJBK3N5TUM3dlNOV25GN3BVb0orWkJLWmNz?=
 =?iso-2022-jp?B?ZTI5eitubWRXUXR6bVlMUEU5ZUhaNHo4cko1SmUvT29pKzVUZ2V4MFc5?=
 =?iso-2022-jp?B?dW1UWllMY1pHSDBWakFGc2ZvYTJGNEEyT2ZjQzJENHgvazZWemY3Rzlx?=
 =?iso-2022-jp?B?MTVlOGlaMUd1OEdtTHNOYldBbnJDQThqSVNqa3pZRTBPSmVuazJRV2FX?=
 =?iso-2022-jp?B?VjBEMUJSeDMwRkFnWlIzMG1mMDJnNVNKbzdaQlhuV0ZBZ1Z1UTloa3R0?=
 =?iso-2022-jp?B?NUNDU1V4WlVZMEVpQ0hUTHppODdueDMwNXFUVy9sWmM2UXQ4cjIyWU1S?=
 =?iso-2022-jp?B?N3hHZTRBeXYwN20vbnBmK2hzOGdoYWNkOTZKM3MySzV5cUh2Q3RNWVkz?=
 =?iso-2022-jp?B?anRJeGFpUFFzQmhkYnRMYkhJWW9pVStMbVBqNTFBdkMranlhcXZKUTFI?=
 =?iso-2022-jp?B?Y1MyTHBnMFAyRDhhODBoVG53NWZMb2ZUOTNrcXZlZ091QXdJVXg3bGh4?=
 =?iso-2022-jp?B?Q1ZCUFppMzVhYStOUUdGZHRwL1lVNlA0clE9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: toshiba.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY7PR01MB14818.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73f68671-4805-47d4-d06d-08dda3bd1372
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jun 2025 23:11:02.6572
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VNb9twAgS1YLA1pJfxp7nYE55THbKCMcJUzp3tbguDeA3SfAiRw782D16YmTPoJRH+ANIQqPmD62IBtpDhD2Orqv8hTraZCUBHWL8lPW4POIvzCOAisBtE6aP4FERI6Y
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYPR01MB12960
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 04 Jun 2025 23:11:27 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19017

Hi Pavel,

I seem to be on the wrong branch you are pushing.
I will revert the linux-5.10.y-cip-rt branch with force push and update lin=
ux-5.10.y-cip.

linux-5.10.y-cip-rt:
  https://gitlab.com/cip-project/cip-kernel/linux-cip/-/commits/linux-5.10.=
y-cip-rt

linux-5.10.y-cip:
  https://gitlab.com/cip-project/cip-kernel/linux-cip/-/commits/linux-5.10.=
y-cip

Best regards,
  Nobuhiro

> -----Original Message-----
> From: cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org> On
> Behalf Of Pavel Machek via lists.cip-project.org
> Sent: Thursday, June 5, 2025 4:32 AM
> To: iwamatsu nobuhiro(=1B$B4d>>=1B(B =1B$B?.MN=1B(B =1B$B""#D#I#T#C!{#C#P=
#T=1B(B)
> <nobuhiro1.iwamatsu@toshiba.co.jp>
> Cc: claudiu.beznea@tuxon.dev; cip-dev@lists.cip-project.org
> Subject: Re: [cip-dev] [PATCH 5.10.y-cip 0/8] RZ/G3S: Backport SCIF suppo=
rt
>=20
> Hi!
>=20
> > >  arch/arm64/boot/dts/renesas/rzg3s-smarc.dtsi  | 21 +++-
> > >  drivers/clk/renesas/r9a08g045-cpg.c           | 10 ++
> > >  drivers/tty/serial/sh-sci.c                   | 96
> > > ++++++++++++++++++-
> > >  7 files changed, 300 insertions(+), 27 deletions(-)  create mode
> > > 100644 arch/arm64/boot/dts/renesas/rz-smarc-pmod1-type-3a.dtsi
> > >  create mode 100644
> > > arch/arm64/boot/dts/renesas/rzg3s-smarc-switches.h
> >
> > I reviewed this series, looks good to me.
> > I can apply this, if there are no other comments.
> >
> > Reviewed-by: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
>=20
> Thank you, applied.
>=20
> Best regards,
> 								Pavel
> --
> DENX Software Engineering GmbH,        Managing Director: Erika Unter
> HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany


