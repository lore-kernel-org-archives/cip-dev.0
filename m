Return-Path: <adithya.balakumar@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E708FC27C79
	for <webhook@archiver.kernel.org>; Thu, 20 Jun 2024 06:10:28 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.152])
 by mx.groups.io with SMTP id smtpd.web10.41198.1718863826968799277
 for <cip-dev@lists.cip-project.org>;
 Wed, 19 Jun 2024 23:10:27 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.152, mailfrom: adithya.balakumar@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1802) id 45K6AOtZ3566956; Thu, 20 Jun 2024 15:10:25 +0900
X-Iguazu-Qid: 2yAbLYkr6kTwlFhvE4
X-Iguazu-QSIG: v=2; s=0; t=1718863824; q=2yAbLYkr6kTwlFhvE4; m=H8GSx4mKVFfZguH7EhyLEe2JByjozaMALUop/qctG3E=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1803) id 45K6ANQ44076561
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 20 Jun 2024 15:10:24 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HIJJ+oVLJOKJt0Gt7Frr8etlNP7eyq7vjmahqxhcj7xInsLJBsJJbyKXBV8JMn9Ty48jWasFeQ1QZtuWaB9TY2TRHI/WY3cL613ZykaMQPdxf7AHmuU/jt170RAcTRaOgraG8ELH4HWch5DyJqB0FXUiDfP/u0uWddqk6nt+fxUolYN9GMbz5TJdz85wMdmeDtej/yjiBrzXq//+SC6Kb/5LG6ArWcrib8ELVhIUxxADVTXmeAJ1dqHO44K8PK3SJnMvQbO8vM0ItR3hxtcMy3CyvEDPUjHqq5ab84li+Hgs81dIT7XTR9EaPdCBpqo7fSsURntPH3ie5WJoDmdAtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cqxWMWAz1QSZFhX1nqD9bdk3i5ABMirtUQNxfb36I4Q=;
 b=WmNmd3hoyhSo4RCEjrAbVPnCYybCiIv2IW5Sm/N2miskrxcvUbQfpePbNfQWo0K98d/6ByyTFKsJpB43dyUqAEFyh06xDIliopBOKfb5Y2KYQDLi9ikFga4ZoC+a7/61k1tKNts+kioAvZnX2+goYO4EV9Nnsxr5ZFl7WYbW+BxcgRL1q2Yvm7KPPanYLLtRM/ZV5wyOYkErUTPYgTY6GVktSQKXdozMXC9HAJa75r5zWM8OHV/7HPHCpWabBmw5yLit5CjMeJdzYoPGtkDW/+5NEuPgQOADZ7OEWBrpwjH0qfFghyXq4uIpltL8ZA/19n06zqvNd78EbrcQ0s4e0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba-tsip.com; dmarc=pass action=none
 header.from=toshiba-tsip.com; dkim=pass header.d=toshiba-tsip.com; arc=none
From: <Adithya.Balakumar@toshiba-tsip.com>
To: <cip-dev@lists.cip-project.org>
CC: <dinesh.kumar@toshiba-tsip.com>, <Shivanand.Kunijadar@toshiba-tsip.com>,
        <Sai.Sathujoda@toshiba-tsip.com>, <kazuhiro3.hayashi@toshiba.co.jp>,
        <koshiro1.onuki@toshiba.co.jp>
Subject: RE: Regarding support for WFX backend for software updates in CIP
 Images
Thread-Topic: Regarding support for WFX backend for software updates in CIP
 Images
Thread-Index: AdrC1ksCFU48h0ptQR+cT3Q7rfn9dAAAgPvg
Date: Thu, 20 Jun 2024 06:10:21 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TYCPR01MB9669E4ECC7E73AF97DEC3447C4C82@TYCPR01MB9669.jpnprd01.prod.outlook.com>
References: <17DAA0C89420B334.21660@lists.cip-project.org>
In-Reply-To: <17DAA0C89420B334.21660@lists.cip-project.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba-tsip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYCPR01MB9669:EE_|OSZPR01MB7017:EE_
x-ms-office365-filtering-correlation-id: 26734769-cfe6-49eb-db3d-08dc90efaad4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230037|376011|1800799021|366013|38070700015;
x-microsoft-antispam-message-info: 
 =?iso-2022-jp?B?M09LZktRd0VjMGRHUTZIaFhOSXJXSkpnSUFzODFBSXE1Y0VTSlV3MlVK?=
 =?iso-2022-jp?B?UGQrakVpcElLYlRPOWxwREVLdWN2MUl2UTFKMGhlSXd6RDdRVW9Jajk4?=
 =?iso-2022-jp?B?eWN1eS9UWjBDVXB3S01EY1h4dUZRbDdBL1BWNUpIN2kwaFdINXAzclVt?=
 =?iso-2022-jp?B?QWdYWi8yUS9sUE9tbS9nQ29kYkNQeG51V0N4WndrQ0FNSmhqT2NzQzNF?=
 =?iso-2022-jp?B?QW8zcnFvUGorUEN4K3kwVStKTzlzUHRnbXdaY0xCTzlQczRFaXhXUWI2?=
 =?iso-2022-jp?B?RmliVHBTajV2UzdNaW1sdHJ6OEtaUVNicXBmR09hRWcxVXRJMDlGc0Rj?=
 =?iso-2022-jp?B?QmZLTm5mYlVrUnVnVTRqT3BoV0FaY2pPZGVyc0R1bTN0OUN4dUQ2MDRG?=
 =?iso-2022-jp?B?WGFjSHI1eDV5Zk1SQWQ0K2FXWFM3YXBBNy9kVjh6Yk00aU5ocEsydFpO?=
 =?iso-2022-jp?B?UGdoQm50Nys1Q3lyTVJTclRrNUVBY2g0S25IMWRKNUIzaHR2WmFxWG5O?=
 =?iso-2022-jp?B?WkRNeGloNnI1cG9rclhkM2txaWs4VXNWeUVuV2tna0RETDFJbU1IVWlW?=
 =?iso-2022-jp?B?SUdMOUNzNHo5eTJ6RXJMVnZ4Z3NVdWlUZDRhQU1rbGhqK1VzNkNxa0Vm?=
 =?iso-2022-jp?B?Z3pnS01nVEdId0hDeXlCSTlWNjB5L0ZXb3ludDlPZnFPTTJLMEZIdjhB?=
 =?iso-2022-jp?B?N1p4QkYwUlp2SG1TMHFaMHRTa2lJK2NIb0J3VWpYekYwbjRUZUpNSlpX?=
 =?iso-2022-jp?B?UVhlU1VkTEJyTk9JOTdyTVV3cVpZN0htUUQ2WmJ1NWw0Yy9Pbis2S2wr?=
 =?iso-2022-jp?B?WjcxVitBaCtVcmxzNG5YR2tadkZWUHRzWS91eDRWS05kQlZBM1Z0ODV6?=
 =?iso-2022-jp?B?YnQvRnFHSjVXYUYxOUEwSzE5T2tuRjNhbExWRHY2V2t0WlFPUEhFY2NZ?=
 =?iso-2022-jp?B?U29rU2tORURoaTBwYVdkTzNEd3ZRcDlja0pSRGZzdlQzd2trcWNiekhq?=
 =?iso-2022-jp?B?aTJqOHRhQWQyOWVBRXNUS1pHcjRMd3N2NjdzTWZlWXVIeTF4czFsdjR6?=
 =?iso-2022-jp?B?dlpMakREZzVOY0R0WjB6ODQzd245Rno5VjdwS1NtbXlSa1ZwWXdBeUt1?=
 =?iso-2022-jp?B?dVd6MWtIczAxUjBIZVlkTENBK1JlVmgvTktPYms2SkFGYkZtWU0xNW9G?=
 =?iso-2022-jp?B?U1JEdUVQTmxDRnJxck9PbDB3RXpCTzVhWEhORWNNMi9uYnQ2Q0JXZElx?=
 =?iso-2022-jp?B?WE5KbDBTbmJSbzZNc0V6RzdBQXRNcGVUbm5TQlhwZFlOUnNWU0ZFY0pB?=
 =?iso-2022-jp?B?NldRalVXRS83ekxtNTRSc29FWWppcmtDL2xnTFhrU0NpMjd5cjJrV3Rl?=
 =?iso-2022-jp?B?SlZHM2F1VUxnZW9xcE9uSkhPWUVCTXArTE0wSWdJd3UybWRyZnVCRVI1?=
 =?iso-2022-jp?B?SFNORDdqcFhCSmlPbnNFQUJNZDVPR3I1TGtIZXlzazExa1lEVG1WYWg1?=
 =?iso-2022-jp?B?TUc1K3EycEMzck0zTjBGejlndzI2aWtpTm9rZ0E1eUFYdVR1UThkQ2lF?=
 =?iso-2022-jp?B?Vkw5ZVlHay9wWVF4WllCRFkwUVFKNFVTMGtjNTRBaHJKY3hSc0JqU2FQ?=
 =?iso-2022-jp?B?NCt6ZVY1cmJuRWJIdHhGZzh4a2F0RXpUbzNkcjNML2pWSmhXeUV2Qnhn?=
 =?iso-2022-jp?B?M3d3K2dQVUFGeVdWYzdmejBhVTcwcUx4RG5JdHBRenI2cU5mUUZjRGNv?=
 =?iso-2022-jp?B?V3l2UzZ2ZFJJcEZDUnd6RkV0TjM2Y1BLM1Mrc1Iyc0szUXRLK2V1Ulhi?=
 =?iso-2022-jp?B?R0NzclB2ZFdlNm0zTmtpeEZXbEFROU1ZSnNHcWtRYkpGZnBvb3oyOU9H?=
 =?iso-2022-jp?B?eFZPMGdEb3hYbHBhK29oYkxqTWZSai92aEorOXJWVDU4YktodmNqQUY3?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB9669.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(376011)(1800799021)(366013)(38070700015);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?b01Wd2hoNTFGTGRRMTR6YkpyS2FicWJvd3NvUkVsbDFtbnVCRk9SYlox?=
 =?iso-2022-jp?B?UWJmSEluWFFuQ0Rrbk1qT3ozVnRGZFRYQ3djSDhkbGxablIreTBBamZm?=
 =?iso-2022-jp?B?WWhoczE5cFQ1VVBCbTgwWFFVRnkwVk1scGY5WGkzVmViS0djSXpqT2Rl?=
 =?iso-2022-jp?B?YkhNZ29Iak1mdklaY1NuWldsQ3ZhUHZMUmZrWEsxRlN0dHlOWVN0d05j?=
 =?iso-2022-jp?B?WkFWalVRR29EVGF2YjhDSytOYmNhSk1FZDVYemZ6Rm0veE1TYWNjMUhB?=
 =?iso-2022-jp?B?NS9kL3BxQXNXWEk5RGkvdjF2Mks1eU9yWVNHd0dyZUdYUUFVUDU0cWdn?=
 =?iso-2022-jp?B?MXQ5UXdLZHh5cnlkejVWaURsWkVQMEpKMEluMHZ0MkpYcFZqN1A0Qzhv?=
 =?iso-2022-jp?B?RzRlcDJTdVBleTR3eXUrQThDdDJMcGtHZk9zWitoVzcyUEgrdTFod2lM?=
 =?iso-2022-jp?B?a2lseDdQTUphbS9haFFHVnpxZ1ZnSUFwU2tOaVRkZmF2SXRLUnprQjBD?=
 =?iso-2022-jp?B?TjVZWFpGWmNoaS9iUTRoc3Y5VmZFZThqM3JMdmFkMXM0WEtOdHZmeHdK?=
 =?iso-2022-jp?B?Zld1ZnFsWUdJSzR1cXBiMCtaZnMvK2Rvbm5iR2w4WjQ3emliYWM3Q0Qy?=
 =?iso-2022-jp?B?ajJCUUs2R0hlb01BdGY1WUZmbkFpVnA4ZVBCRjBsTm1Od3YySFZmNzFm?=
 =?iso-2022-jp?B?RGl4Z3VnazlMS0xIYVJZbU1iTmpoam5xNXJRTWtpK01FQVFhakx5YnVh?=
 =?iso-2022-jp?B?NVRuU2Nud1V2Uy9VS3BUUEVxWWw2ZjJpQmFTOXZuQWJwSEo2Vm5kMVNl?=
 =?iso-2022-jp?B?dWJOM1g3SjZyemY0SEFWLy9SN25aTUpwdzlsN0RjSlQvRFdMcGF0TDNQ?=
 =?iso-2022-jp?B?czk3UEYyaFpiRHJRWGtXMkV2ZHdZN044dlF1MUJXenpoZVo2bmxER1BI?=
 =?iso-2022-jp?B?OEdwSy9YVHhXUm4xd2V3em9CeHZWUUhhTm5WTVArelVoZFFuaUJYU0Nn?=
 =?iso-2022-jp?B?YmV0L05nYTkvTHZ4WkI0aGprdkROaGVPSU0wL01KMTRFRzNnYmNXaWMw?=
 =?iso-2022-jp?B?R1h5a0RFWCthaDZKc3ByaW5HMHhyOCtXbVpRRzI5M1M0Q2JiUGVlclRy?=
 =?iso-2022-jp?B?dVVPaGkzdmtPTE9qQUNSNVhTOC85ZDAyK2FuNzRwL1Z6di9Hc3o1NXI0?=
 =?iso-2022-jp?B?eitEcGs4YWUvRmJxVm5mNFF4MW1kS2piM21Xd1Y0WmpFUzM3c1AyaVR1?=
 =?iso-2022-jp?B?YUUzM3RTMFVOU0d2Vm5MSWcwZVJ4WGM1SlRxekM4UFhORXl3WWtib29G?=
 =?iso-2022-jp?B?K0NpYkVDa0lzRXFpUTRxZk0yQVkyOWhnMVhYd2toYWxxeWl4NGhjSlpw?=
 =?iso-2022-jp?B?c0lEa001a05HVWE0MTRmZDByU0svMXo4OTFpYWowUWNUbmJCT1ZEVjJ0?=
 =?iso-2022-jp?B?ZXJ5a2pTcHUyRTFYTm1HSytqNUpqQWYxTW5tY2w2d1pPTkdZelBhNkhk?=
 =?iso-2022-jp?B?SDUwTjJWUGpablk4K1VKYUpqTFoyNnpkL3piOTlheGxrZkNWNlllZjh6?=
 =?iso-2022-jp?B?QlpqbmNrVmUzRHZWYXkyYjB1TU9ORWY3M1d1RlEvc2VjZFZWdGVsS1Av?=
 =?iso-2022-jp?B?M2NzT3hTalc2Szk2UVlHdkw1MXpTVGtjbzV5OVY3UGxaTURsMHFTYTcv?=
 =?iso-2022-jp?B?ZXRqeUlrKzVCZDJENk5yWkdna0diWk5VM1ZoWWtPVmNZSGdMbEt3TVlM?=
 =?iso-2022-jp?B?akprOW5IMlZzWG5TVG9rZ1NHTGdXVk1Pakk1cnh5NGlUZmx2ZU9TMjNm?=
 =?iso-2022-jp?B?TEtHOW9GbUFmWGltc2dWZzFxZTRNdHFwKys0RlhCTTBqdFFYaVQrcmZP?=
 =?iso-2022-jp?B?UlNCNmdtQmN6U0RrNHo4Z002TGFWM3JBaXFNYnNRY0t6czZuaitnNkRS?=
 =?iso-2022-jp?B?S2s0eUs0enJreUN6bHVaOUJVak9zblZ5VE12Y1FyWmZBeE1Jcm4vUEpC?=
 =?iso-2022-jp?B?d05RQk0yZ21oUHZkWlRDTUNWY2taWjBFaGg5TUZHdG5aQzl0cTlqUzFJ?=
 =?iso-2022-jp?B?RXVNeVd5Z1hUMkFvMUZmZXRUbDJaNEpEVm5qblp4REthOWkwbFM4SHIr?=
 =?iso-2022-jp?B?Uk5CY0xCVlBPejhtWXRaMktUMmcxQkhpampUYTJnUmN0VHVGMU1KYXVE?=
 =?iso-2022-jp?B?RW5wSTdyYUdMQmlpNCtCZGdvVm50YmFjeHZseVdwRFFiRmNmVXEyNGJB?=
 =?iso-2022-jp?B?cU1qeEQ5R01sRmtKanBsSXBKcTZZMjlzbHpONVhvM243aXR6QVFJUSsw?=
 =?iso-2022-jp?B?emdMRW1odi9tNmJaWWpZQ3dDemI0YnpmUFp3TUpDQ3NPZmJCMktzK0Vj?=
 =?iso-2022-jp?B?M29ncm89?=
Content-Type: multipart/alternative;
	boundary="_000_TYCPR01MB9669E4ECC7E73AF97DEC3447C4C82TYCPR01MB9669jpnp_"
MIME-Version: 1.0
X-OriginatorOrg: toshiba-tsip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB9669.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 26734769-cfe6-49eb-db3d-08dc90efaad4
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jun 2024 06:10:21.7210
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pA13vNlB591LckRPH5RoK+N/j6eG8iDWvOVmh/XlmeqgJJS7tmZNHOiiqIibjT3+eSVvGXs2M6GA1UnpdAUywK/g87i23Jf8ivwfpVMxP/LbeNczfnHj2Rb/zfiyrjTU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB7017
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 20 Jun 2024 06:10:28 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16302

--_000_TYCPR01MB9669E4ECC7E73AF97DEC3447C4C82TYCPR01MB9669jpnp_
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable

Adding Koshiro Onuki san from Toshiba to the mail chain

From: cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org> On Beha=
lf Of Adithya Balakumar
Sent: Thursday, June 20, 2024 11:26 AM
To: cip-dev@lists.cip-project.org
Cc: dinesh kumar(=1B$B#T#S#I#P=1B(B TMIEC ODG Porting) <dinesh.kumar@toshib=
a-tsip.com>; kunijadar shivanand(=1B$B#T#S#I#P=1B(B TMIEC ODG Porting) <Shi=
vanand.Kunijadar@toshiba-tsip.com>; ashrith sai(=1B$B#T#S#I#P=1B(B) <Sai.Sa=
thujoda@toshiba-tsip.com>; hayashi kazuhiro(=1B$BNS=1B(B =1B$BOB9(=1B(B =1B=
$B#D#M#E=1B(B =1B$B!{#D#I#G""#M#P#S!{#M#P#4=1B(B) <kazuhiro3.hayashi@toshib=
a.co.jp>
Subject: [cip-dev] Regarding support for WFX backend for software updates i=
n CIP Images

Hi All,

This is regarding support for WFX backend for software updates in CIP Image=
s. I am writing to understand the opinions of the community on how to go ab=
out with the integration of WFX support.

As I understand there are 2 parts to the WFX integration:
1. Hosting the WFX server.
2. Suricatta configuration in the CIP Images via the swupdate.cfg for commu=
nication with WFX server.

As from the device side, communication with the WFX server is already suppo=
rted by SWUpdate through the server_wfx.lua module. See [1].
However the necessary suricatta configs in the swupdate.cfg file are requir=
ed to be set which is currently missing from image recipes.

Based on CIP Core work group meetings, I understand that there is already a=
 plan to host a WFX server for CIP related purposes. While that is still in=
 the works, would it be alright to update recipes to include the necessary =
configs needed for WFX support or wait for the server side to be completed?

Until the planned WFX server setup is completed, how about including detail=
s of setting up a WFX server and other details for minimal verification in =
a README file?

Would like to understand the opinions of the maintainer and the rest of the=
 community on such an approach and also other ideas on how to go about with=
 this integration?


[1]: https://github.com/sbabic/swupdate/blob/master/suricatta/server_wfx.lu=
a


Thanks and Regards,
Adithya Balakumar

--_000_TYCPR01MB9669E4ECC7E73AF97DEC3447C4C82TYCPR01MB9669jpnp_
Content-Type: text/html; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-2022-=
jp">
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<style><!--
/* Font Definitions */
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:Aptos;}
@font-face
	{font-family:"MS PGothic";
	panose-1:2 11 6 0 7 2 5 8 2 4;}
@font-face
	{font-family:"\@MS PGothic";}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	font-size:11.0pt;
	font-family:"Aptos",sans-serif;
	mso-ligatures:standardcontextual;
	mso-fareast-language:JA;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:#467886;
	text-decoration:underline;}
span.EmailStyle19
	{mso-style-type:personal-reply;
	font-family:"Aptos",sans-serif;
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;
	mso-ligatures:none;}
@page WordSection1
	{size:8.5in 11.0in;
	margin:1.0in 1.0in 1.0in 1.0in;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"EN-US" link=3D"#467886" vlink=3D"#96607D" style=3D"word-wrap:=
break-word">
<div class=3D"WordSection1">
<p class=3D"MsoNormal"><span style=3D"mso-fareast-language:EN-US">Adding Ko=
shiro Onuki san from Toshiba to the mail chain<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"mso-fareast-language:EN-US"><o:p>&nbs=
p;</o:p></span></p>
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal" style=3D"margin-left:.5in"><b><span style=3D"font-fa=
mily:&quot;Calibri&quot;,sans-serif;mso-ligatures:none">From:</span></b><sp=
an style=3D"font-family:&quot;Calibri&quot;,sans-serif;mso-ligatures:none">=
 cip-dev@lists.cip-project.org &lt;cip-dev@lists.cip-project.org&gt;
<b>On Behalf Of </b>Adithya Balakumar<br>
<b>Sent:</b> Thursday, June 20, 2024 11:26 AM<br>
<b>To:</b> cip-dev@lists.cip-project.org<br>
<b>Cc:</b> dinesh kumar(</span><span lang=3D"JA" style=3D"font-family:&quot=
;MS PGothic&quot;,sans-serif;mso-ligatures:none">=1B$B#T#S#I#P=1B(B</span><=
span style=3D"font-family:&quot;Calibri&quot;,sans-serif;mso-ligatures:none=
"> TMIEC ODG Porting) &lt;dinesh.kumar@toshiba-tsip.com&gt;; kunijadar shiv=
anand(</span><span lang=3D"JA" style=3D"font-family:&quot;MS PGothic&quot;,=
sans-serif;mso-ligatures:none">=1B$B#T#S#I#P=1B(B</span><span style=3D"font=
-family:&quot;Calibri&quot;,sans-serif;mso-ligatures:none">
 TMIEC ODG Porting) &lt;Shivanand.Kunijadar@toshiba-tsip.com&gt;; ashrith s=
ai(</span><span lang=3D"JA" style=3D"font-family:&quot;MS PGothic&quot;,san=
s-serif;mso-ligatures:none">=1B$B#T#S#I#P=1B(B</span><span style=3D"font-fa=
mily:&quot;Calibri&quot;,sans-serif;mso-ligatures:none">) &lt;Sai.Sathujoda=
@toshiba-tsip.com&gt;;
 hayashi kazuhiro(</span><span lang=3D"JA" style=3D"font-family:&quot;MS PG=
othic&quot;,sans-serif;mso-ligatures:none">=1B$BNS=1B(B</span><span lang=3D=
"JA" style=3D"font-family:&quot;Calibri&quot;,sans-serif;mso-ligatures:none=
">
</span><span lang=3D"JA" style=3D"font-family:&quot;MS PGothic&quot;,sans-s=
erif;mso-ligatures:none">=1B$BOB9(=1B(B</span><span lang=3D"JA" style=3D"fo=
nt-family:&quot;Calibri&quot;,sans-serif;mso-ligatures:none">
</span><span lang=3D"JA" style=3D"font-family:&quot;MS PGothic&quot;,sans-s=
erif;mso-ligatures:none">=1B$B#D#M#E=1B(B</span><span style=3D"font-family:=
&quot;Calibri&quot;,sans-serif;mso-ligatures:none"> =1B$B!{=1B(B</span><spa=
n lang=3D"JA" style=3D"font-family:&quot;MS PGothic&quot;,sans-serif;mso-li=
gatures:none">=1B$B#D#I#G=1B(B</span><span style=3D"font-family:&quot;Calib=
ri&quot;,sans-serif;mso-ligatures:none">=1B$B""=1B(B</span><span lang=3D"JA=
" style=3D"font-family:&quot;MS PGothic&quot;,sans-serif;mso-ligatures:none=
">=1B$B#M#P#S=1B(B</span><span style=3D"font-family:&quot;Calibri&quot;,san=
s-serif;mso-ligatures:none">=1B$B!{=1B(B</span><span lang=3D"JA" style=3D"f=
ont-family:&quot;MS PGothic&quot;,sans-serif;mso-ligatures:none">=1B$B#M#P#=
4=1B(B</span><span style=3D"font-family:&quot;Calibri&quot;,sans-serif;mso-=
ligatures:none">)
 &lt;kazuhiro3.hayashi@toshiba.co.jp&gt;<br>
<b>Subject:</b> [cip-dev] Regarding support for WFX backend for software up=
dates in CIP Images<o:p></o:p></span></p>
</div>
</div>
<p class=3D"MsoNormal" style=3D"margin-left:.5in"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal" style=3D"margin-left:.5in">Hi All,<o:p></o:p></p>
<p class=3D"MsoNormal" style=3D"margin-left:.5in">&nbsp;<o:p></o:p></p>
<p class=3D"MsoNormal" style=3D"margin-left:.5in">This is regarding support=
 for WFX backend for software updates in CIP Images. I am writing to unders=
tand the opinions of the community on how to go about with the integration =
of WFX support.
<o:p></o:p></p>
<p class=3D"MsoNormal" style=3D"margin-left:.5in">&nbsp;<o:p></o:p></p>
<p class=3D"MsoNormal" style=3D"margin-left:.5in">As I understand there are=
 2 parts to the WFX integration:<o:p></o:p></p>
<p class=3D"MsoNormal" style=3D"margin-left:.5in">1. Hosting the WFX server=
.<o:p></o:p></p>
<p class=3D"MsoNormal" style=3D"margin-left:.5in">2. Suricatta configuratio=
n in the CIP Images via the swupdate.cfg for communication with WFX server.=
<o:p></o:p></p>
<p class=3D"MsoNormal" style=3D"margin-left:.5in">&nbsp;<o:p></o:p></p>
<p class=3D"MsoNormal" style=3D"margin-left:.5in">As from the device side, =
communication with the WFX server is already supported by SWUpdate through =
the server_wfx.lua module. See [1].<o:p></o:p></p>
<p class=3D"MsoNormal" style=3D"margin-left:.5in">However the necessary sur=
icatta configs in the swupdate.cfg file are required to be set which is cur=
rently missing from image recipes.&nbsp;
<o:p></o:p></p>
<p class=3D"MsoNormal" style=3D"margin-left:.5in">&nbsp;<o:p></o:p></p>
<p class=3D"MsoNormal" style=3D"margin-left:.5in">Based on CIP Core work gr=
oup meetings, I understand that there is already a plan to host a WFX serve=
r for CIP related purposes. While that is still in the works, would it be a=
lright to update recipes to include
 the necessary configs needed for WFX support or wait for the server side t=
o be completed?<o:p></o:p></p>
<p class=3D"MsoNormal" style=3D"margin-left:.5in">&nbsp;<o:p></o:p></p>
<p class=3D"MsoNormal" style=3D"margin-left:.5in">Until the planned WFX ser=
ver setup is completed, how about including details of setting up a WFX ser=
ver and other details for minimal verification in a README file?<o:p></o:p>=
</p>
<p class=3D"MsoNormal" style=3D"margin-left:.5in">&nbsp;<o:p></o:p></p>
<p class=3D"MsoNormal" style=3D"margin-left:.5in">Would like to understand =
the opinions of the maintainer and the rest of the community on such an app=
roach and also other ideas on how to go about with this integration?<o:p></=
o:p></p>
<p class=3D"MsoNormal" style=3D"margin-left:.5in">&nbsp;<o:p></o:p></p>
<p class=3D"MsoNormal" style=3D"margin-left:.5in">&nbsp;<o:p></o:p></p>
<p class=3D"MsoNormal" style=3D"margin-left:.5in">[1]: <a href=3D"https://g=
ithub.com/sbabic/swupdate/blob/master/suricatta/server_wfx.lua">
https://github.com/sbabic/swupdate/blob/master/suricatta/server_wfx.lua</a>=
<o:p></o:p></p>
<p class=3D"MsoNormal" style=3D"margin-left:.5in">&nbsp;<o:p></o:p></p>
<p class=3D"MsoNormal" style=3D"margin-left:.5in">&nbsp;<o:p></o:p></p>
<p class=3D"MsoNormal" style=3D"margin-left:.5in">Thanks and Regards,<o:p><=
/o:p></p>
<p class=3D"MsoNormal" style=3D"margin-left:.5in">Adithya Balakumar<o:p></o=
:p></p>
</div>
</body>
</html>

--_000_TYCPR01MB9669E4ECC7E73AF97DEC3447C4C82TYCPR01MB9669jpnp_--


