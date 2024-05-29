Return-Path: <sai.sathujoda@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEEE4C25B75
	for <webhook@archiver.kernel.org>; Wed, 29 May 2024 09:34:38 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.135])
 by mx.groups.io with SMTP id smtpd.web10.9671.1716975277025890595
 for <cip-dev@lists.cip-project.org>;
 Wed, 29 May 2024 02:34:37 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.135, mailfrom: sai.sathujoda@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1801) id 44T9YZgZ4032634; Wed, 29 May 2024 18:34:35 +0900
X-Iguazu-Qid: 2yAbxjwjw6GjBbYnsB
X-Iguazu-QSIG: v=2; s=0; t=1716975274; q=2yAbxjwjw6GjBbYnsB; m=mP4lTdfDAIGjhsp90fls45vbs5h9oAjM8lSiIP7sJjQ=
Received: from imx12-a.toshiba.co.jp ([38.106.60.135])
	by relay.securemx.jp (mx-mr1800) id 44T9YXGF1171067
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 29 May 2024 18:34:34 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ksHVaNfur0R6Tl+jWfRul53JL/VeiI2ihGh7J9rlmij8QRz3E9tn53hEJyKai84NsTUgb4Xz1sewpI1iMIyJCtNTUS1c8dWMedmzP1+yzX2I2G3kWOSzbVYrizMIJDCP3LrO+AhFEOXLgetF/cYnGxKxF0aXYCU+5Gxi+Fmfoi0JanwuQmnACAL2z6Q3KegJ/j9erCwgcg5mUx9KmCca+mMWvInvqc+4P4uHb8mtavDdgGcw9Twzi376gc4wNyXW5oOZOca7WWtW+wUpyUPMZQYHZexkdPQh3k1z25UB6zAB9Y6E7LYUxejCGu/FTVrwrTBgW4DcwkovhYrzYDbv2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c4Hu9Uj32OP9TMKJaueuKti+Y2EdjjSseGu6t1hQApU=;
 b=jOtdzsOglaMNIURBrxtF2NAu6ikApY6oac7aFEqVB4m+P8Q13TTlxbQBQzdmEYXe0M9ygFc3JReUA8BI8ixMGIt9QiXkoYGDNlH6DXkkhqCxLnA3Zqw1DSuks8ywxJlYcseq7kxCYQvLj1KVLClUQCx2g06dBSpoeq4cy1jUa/dV+z6LZGjFxHMd267hi6ADyy725ozLDeacsztgCp8WCnj22Jw/UKlMB4SFMYsYvQblRlQWCpMQlGARYsq95My3/+s1JjteNohhgKcNt2CGIWcXfsudteqjWAUJCng97W/Pat1dAc1dfhojXkvX9SRd4SnuFYn0t5jDkzBWpBajIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba-tsip.com; dmarc=pass action=none
 header.from=toshiba-tsip.com; dkim=pass header.d=toshiba-tsip.com; arc=none
From: <Sai.Sathujoda@toshiba-tsip.com>
To: <Chris.Paterson2@renesas.com>
CC: <cip-dev@lists.cip-project.org>, <kazuhiro3.hayashi@toshiba.co.jp>,
        <dinesh.kumar@toshiba-tsip.com>
Subject: RE: Unable to start swtpm_start.sh
Thread-Topic: Unable to start swtpm_start.sh
Thread-Index: AdqxZjRcYVHYPZxaT7+kSAcinUMJhgAQCb5gAAE2fQA=
Date: Wed, 29 May 2024 09:34:30 +0000
X-TSB-HOP2: ON
Message-ID: 
 <OS3PR01MB610375A3AF315A3A9995F563C2F22@OS3PR01MB6103.jpnprd01.prod.outlook.com>
References: 
 <OS3PR01MB610382522DF0932C7EB0CEB6C2F22@OS3PR01MB6103.jpnprd01.prod.outlook.com>
 <TYWPR01MB118625C09DB4B02CD05FF2A75B7F22@TYWPR01MB11862.jpnprd01.prod.outlook.com>
In-Reply-To: 
 <TYWPR01MB118625C09DB4B02CD05FF2A75B7F22@TYWPR01MB11862.jpnprd01.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba-tsip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS3PR01MB6103:EE_|TYCPR01MB9553:EE_
x-ms-office365-filtering-correlation-id: a6214941-8e3b-4eee-1840-08dc7fc28ae6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|1800799015|366007|376005|38070700009;
x-microsoft-antispam-message-info: 
 =?iso-2022-jp?B?eXZ5RERCL3ZXY2R1WnJ2RGhPNEtMaUJyYnV0TG53eVpFbUpESFlWR2U2?=
 =?iso-2022-jp?B?WGdBZXBpVlNOb081dzRxSmFMeE53ZHI2V2RCRHQ5c3RXYUZpNW95UG9K?=
 =?iso-2022-jp?B?azg3TGJLUUJGVnRrNUw1QnJ5Q3Y1dU00NEtGZzRIZkZBQ0VIbmsxYmdQ?=
 =?iso-2022-jp?B?bllZcEJ6cFJuemUrYU8xMlJUZm9Ud1dtVDEvREpSa09LNnFteHhuQ2t4?=
 =?iso-2022-jp?B?NEF3Rjh1RWVpdVVFVzF3alJJY0lKbkpoUzhPYmFQUENyaDhwZXpab3hJ?=
 =?iso-2022-jp?B?SzdDT1VPWmpUT003Q1pJVGIxbCtvYjBNbVFPRHYxYWhGNDFHU29NQUI4?=
 =?iso-2022-jp?B?aGdrQWU1M2V3b2ZadzBSQ1dIdDZqeE1BMiswT1hmZkpsdS95bjl3cm5U?=
 =?iso-2022-jp?B?YmRIQmJZR1g5MU5uNjhmWDBFQUNSSyt3ZSs5L2ZSVGczc01kcUtjQ1VC?=
 =?iso-2022-jp?B?aTV2cTlQVXZGR3daZVFRNXNjaUNVTlh6OHFSdnJyM2E0eFhkSFBYOEdU?=
 =?iso-2022-jp?B?NWtSN2o3ZTYvc3RvN09OSTlrUE9VcTNBeDlqSTZMUHgrdmx3cDJKYnVF?=
 =?iso-2022-jp?B?aDcwN3RSZVZ0UGhJTERMalpsUVBxUmpOOG4rbmxoQXhxRU1JRHMra0Iz?=
 =?iso-2022-jp?B?cnZCTUtNMC9VZDl4UCtISC8xcFV3RmV6UGxwam5WY1pYem4rSzh3YVRP?=
 =?iso-2022-jp?B?Tm9Fa3ZaV1hGeVBwZjVjeHkzN1ZBMFMvM0NrWWlaU3I0a0M5a01UUDZr?=
 =?iso-2022-jp?B?SG5pSGN0V25BTnIxSnpzTHVJMlRQUG9UMDNMMTlvWFo0WldLUVlEaW9s?=
 =?iso-2022-jp?B?Y1FLRDhjTm9lMHlMS1V2UTFDaTdWUnZIMUJsb2hhc1Y0ZjNaTDZVbFdQ?=
 =?iso-2022-jp?B?WnJ5d3U5aW1OWjdodG9kWndqYy9jRkVCemNQcGpaWlJiOWVwL2VWMDYx?=
 =?iso-2022-jp?B?bVBTd0VTd2krUXM1Ui9XTkVrVE1yZ3QzRTNHYWhkcUdEZXNBWjI5amxw?=
 =?iso-2022-jp?B?bXNsY1R3VU5PWUFLVk1BRmtwMXcrSUROV3BkTUJ2VENWQ0MyUEhDWGlQ?=
 =?iso-2022-jp?B?RWlZeHVTSGVvak9BNllTd3VjL3dCZWE0YmFLK2ZoWDRaWnBub1ByczVU?=
 =?iso-2022-jp?B?dFV6UzlyT2l2Ni8xSWtaVlFVamhRbk1OdndLNDNJMlllMkhsWnR3MEVi?=
 =?iso-2022-jp?B?eFZ6NVdBaThTc3NabVpNVTRTdlVIbEg0NUtDamZZQmM3RWFuQ0FyaklU?=
 =?iso-2022-jp?B?K01LcEtsUEl0Y1V2MEFlRGgyM3cyZUE3RGMrczlIYk1IN2hoVmlUWTNW?=
 =?iso-2022-jp?B?cklnR0lha2JGTzFTQTNCWUZUNXJJaWJEV29xRGVwZTJxUjVqcURtMlV1?=
 =?iso-2022-jp?B?MUpNSldtbGc3QU1KUUg3UDJ4Sjh3WTVuQ2NoZjNDbHYwTTdMNTVRTmhh?=
 =?iso-2022-jp?B?ei9jb0J1U2k1VUQvcURGNW9ZWnNGdnMzdTMwZWFaejR1RnQyQkV0TDlx?=
 =?iso-2022-jp?B?b3pHclRDaHBYUktmRktZVVlJYnE5eEVWZzdGZGNrN3pyaFI1R3dTMEZu?=
 =?iso-2022-jp?B?WmtmK0V3S0RqV0FUTjRIc25KWHpIb2xvRi85NThEUGlMK2hRMlRhTHdM?=
 =?iso-2022-jp?B?MkZyQkIxUmxtTzg2UExkaUpKOVFZQy9uNC9SSGFJbTJCTHlIREdQemEz?=
 =?iso-2022-jp?B?R2RBcmRJczAyR0N0c2QyU1lydEZySGVXaVlXcElxdkg4dHFqbTRqdzhn?=
 =?iso-2022-jp?B?T3VleHVJOVlGU1c0UTJYdlNoU3NsUkNtM05RMGtYcnl5dUZvU2Z1TDhX?=
 =?iso-2022-jp?B?QlFtbWRCa2F3Q29YTDFTeUdoUnBheCtrY2lOTE1UZzI1djlob0VkNUZi?=
 =?iso-2022-jp?B?MTd5K2pPYVhsdUNBNTJqMHNCb1dJPQ==?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS3PR01MB6103.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?OFA1aGNacThyTVBkM0hsMTNkWHFJYVhsbWNONTE0cDZnNEJ3NFRxanJq?=
 =?iso-2022-jp?B?cW1EZFBvRUUzRmFmYStmVjkxSVNrbkFLSDUrV2pqQUt0QWFPck11Rlhq?=
 =?iso-2022-jp?B?MWlGSnZiQ2xoT1V4NnA2Q3ROd01Dak81ODVxTGF0NnFiRUcrWHVmWXV5?=
 =?iso-2022-jp?B?Q3EwdWNRazFkWEJtc09PNUQ2Q2VBcU80UHNCYXlBNkRaUWUrSFVrOEhq?=
 =?iso-2022-jp?B?WUJoSVhrelJnaE5pNTZ4U21ORUREeGkyM0FxZ0huVy82aVIzZ2lpVjhU?=
 =?iso-2022-jp?B?SnpiT2hpQlpnREo5NmNwRjUyZXZxQkpUT3hldDJKdWlaUU5BNnpBUTE2?=
 =?iso-2022-jp?B?dU92cm9XTkFqOHI5ai9hc3RVbTM4Q2h0RWx3bEZSeDBBdVBUbXJvL0NR?=
 =?iso-2022-jp?B?cFc3RVZza0oxcUtESDMyMGhMWjJRR3dJUVpEZ1o3YXMyMjFVUlhkY3NE?=
 =?iso-2022-jp?B?MGhBNTdvTS83S2VHN3k2M2hQRlUyNTFOZjluU2ZvVS8zaWY1L1RJa2p4?=
 =?iso-2022-jp?B?dmQ5MXVpam5MQS9OaEQ2NUpaZVBma0ZleTZKWnhyWHdTdFFCZitIcnY4?=
 =?iso-2022-jp?B?OTNKcHAvcVpZc2hWWUZCS0VLODd6bFZlRkR3c3VBeTZrVTY1ZkNOV2NV?=
 =?iso-2022-jp?B?bkxKeDNjV1ZwR2c2bWNwS3J2dmp1Mk5BcnBLOFd3d3laVld2RjI0ZWdP?=
 =?iso-2022-jp?B?MkEva05Bcy8vS0dyM1RTVU5mOHZBSFdIOWFyMnZZQUN5NUpwdXBmOFR5?=
 =?iso-2022-jp?B?NDFHL2dIZ3ZQL0xhQlFEZjJXMDV0d0FqYVNnWThUVTZnTXRybTdvQTN0?=
 =?iso-2022-jp?B?KzNoZEQ2UjA3UmdZWUpQRmlPem5oUjhFUGlyUHJ1SWJlNTQvd0JHSjlP?=
 =?iso-2022-jp?B?NW1ueXM5QXJrS096V3lvL2NFUk5CNU4rNW5vT3UzQ3QxM3o5NjE2Mnkz?=
 =?iso-2022-jp?B?V3hWUmc3RlNaVUluT1o5RTBoT1g5ek1qZDRxcHUxbWFCSmlGa2tSUFlz?=
 =?iso-2022-jp?B?YzBic1lBS1ByTmFwSmVQQndCTWxaYWVQQzViTERodGlkNks5aG9neTlW?=
 =?iso-2022-jp?B?bXVNZ2gyV0p1TEJ3NEw2aGFFOHo3bE1IQ3pCQ2VmVGdwV0hHU0FrYktq?=
 =?iso-2022-jp?B?b2Q4aW9GYVBJWVgwQUNTYS9nQnBBQjcrVmdrTDZJeFJKMi9rZ2lESUFk?=
 =?iso-2022-jp?B?aTFEK1ljRXBwNktydDVMNUJZQ0lQaWRqMGJqMkE4QTRtZWxrSjdLalZl?=
 =?iso-2022-jp?B?UlBsS2hFa2JDNnY1UEdEa1BCd1l6M2g3VXc1T2VWZWdpcllpb3Nhd01W?=
 =?iso-2022-jp?B?NVhFNWcwQ0NlWHloNmNkc2EvWFYvUUkwbEpiaFNrTmRkaUd4blo2UVYw?=
 =?iso-2022-jp?B?eVF6VWtwV1JvQzZzWDJhMmpGNGpBZ3REbFh3aURpQW12ODJLYzU5N3hq?=
 =?iso-2022-jp?B?NUk5MjMwZVVDUXY5N2Y0K0tmNVNOVGh1WmdHU05iL0lKRTlzeDJLQ0F4?=
 =?iso-2022-jp?B?V2hxQWpOa1VqanUzSUx0YzBSVGYrOStBbWNjaUNKMGhabkE5NkE2d3k5?=
 =?iso-2022-jp?B?WjZQVkVLSnlJSGpJaHVSVDUzZmcwRi81dWxnOHMvcWNrSWphbFMyWkty?=
 =?iso-2022-jp?B?bXJCU1R4ZThFTHlPMVh1cytDSDBpUGc5TDdFa29kZ1c0UmhvRnhYZFNz?=
 =?iso-2022-jp?B?bnB3b1U2UFNnZ2Q1akFnRk9mcUVwcTFXL2ZiQk5nWkxLZWtVZUJnUTZN?=
 =?iso-2022-jp?B?WElCMzZ6VG5uaGlJMWZGRmFPTExtb3A5RURSbk9GVFlTbjRpMWNRY0hY?=
 =?iso-2022-jp?B?QXAxeUlQNDMyQTBhblBPeitHOEdPaGY3WExRYm1lci9JcnRDM3NuSTRa?=
 =?iso-2022-jp?B?LzdnTmVOYloyTzdmMjdvZmcxMlpsMWJUdzQ0ay9ZaVB2VG94RHI2dGZB?=
 =?iso-2022-jp?B?R2pJUzYvN2lRSCtNZ0dPYjJiazlNSTc3Tk12dGczUGNueG5QV3h4WWQ3?=
 =?iso-2022-jp?B?VlZVNlo5aXpHTjlCT3ZHMzh1aUxyS053SkhseWNOTjNjK09QSmNIVGVr?=
 =?iso-2022-jp?B?cjVFaFYzYXZTVVgrMnljQUgvRVpBekFxNUUwMitDQjcwNFUreTlCd1VO?=
 =?iso-2022-jp?B?U0lRMFJ5NXVlS08vZWs2ODlpdCtsQ05NK280QXQ3VklGWjRmMVN1M3hB?=
 =?iso-2022-jp?B?eFBFTmZQME1xbFk2N1hLN1N1eThqczhDbTVmTGFZdXZzck5hWnEreFZE?=
 =?iso-2022-jp?B?anlvRGtoRTZXU05xdFYwZ3JNWTNFWm1PRlNYcHFEZkpBRXg4NWJ6TGFG?=
 =?iso-2022-jp?B?SWJHZ0tFNUtkMVZycE1OU2NsSDRpYmV4eFE9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: toshiba-tsip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS3PR01MB6103.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a6214941-8e3b-4eee-1840-08dc7fc28ae6
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 May 2024 09:34:31.0406
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ToDgLSGO1ze/WrUWvSYyl8tAZVnwoKU3eU/VHDecAVcKD/AHn2SluT/HiBR09Zp38iwOzj2+jq4pwAtFUJaD6whtKG346MHt0TAPx00uAFs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB9553
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 29 May 2024 09:34:38 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16063

Hi Chris,

Let me also debug this in my local setup parallelly.

Thanks and regards,
Sai Ashrith Sathujoda (T S I P)

-----Original Message-----
From: Chris Paterson <Chris.Paterson2@renesas.com>=20
Sent: Wednesday, May 29, 2024 2:30 PM
To: ashrith sai(=1B$B#T#S#I#P=1B(B) <Sai.Sathujoda@toshiba-tsip.com>
Cc: cip-dev@lists.cip-project.org; hayashi kazuhiro(=1B$BNS=1B(B =1B$BOB9(=
=1B(B =1B$B#D#M#E=1B(B =1B$B!{#D#I#G""#M#P#S!{#M#P#4=1B(B) <kazuhiro3.hayas=
hi@toshiba.co.jp>; dinesh kumar(=1B$B#T#S#I#P=1B(B TMIEC ODG Porting) <dine=
sh.kumar@toshiba-tsip.com>
Subject: RE: Unable to start swtpm_start.sh

Hi Sai,

> From: Sai.Sathujoda@toshiba-tsip.com <Sai.Sathujoda@toshiba-tsip.com>
> Sent: Wednesday, May 29, 2024 2:29 AM
>=20
> Hi Chris,
>=20
>=20
>=20
> After the scripts were included and device dictionary changes were=20
> made to
> qemu-renesas-01 and qemu-patersonc-01. I tried to run the jobs, but=20
> swtpm_start.sh  is unable to return 0 as it was doing previously which=20
> is making the job get stuck until time out. LAVA | Scheduler | Jobs |=20
> 1139794
> (ciplatform.org) <https://lava.ciplatform.org/scheduler/job/1139794>  .
>=20
>=20
>=20
> In the end it is also mentioning that it is an infrastructure error=20
> and to report it to LAVA admins. For comparison here is a successful=20
> job which ran recently on qemu-renesas-01 with your manual changes. ->=20
> LAVA | Scheduler | Jobs | 1132059 (ciplatform.org)=20
> <https://lava.ciplatform.org/scheduler/job/1132059>  .  Previously in=20
> your manual changes to Renesas slave, there used to =1B$B!H=1B(Becho $?=
=1B$B!I=1B(B instead=20
> of return
> 0 here=20
> https://gitlab.com/cip-project/cip-testing/lava-docker/-/blob/cip-
> lava-docker/lava-slave/scripts/swtpm_start.sh#L18=20
> <https://gitlab.com/cip-
> project/cip-testing/lava-docker/-/blob/cip-lava-docker/lava-
> slave/scripts/swtpm_start.sh#L18>  which made swtpm start successfully=20
> but that should not make any difference, right ?

So the script works as expected in your local environment, but not in LAVA?
I'm not sure why this would be the case TBH.
I'll have to do some debugging.

Chris


