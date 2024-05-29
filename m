Return-Path: <chris.paterson2@renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7D9BC27C43
	for <webhook@archiver.kernel.org>; Wed, 29 May 2024 12:44:59 +0000 (UTC)
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (JPN01-TYC-obe.outbound.protection.outlook.com [40.107.114.82])
 by mx.groups.io with SMTP id smtpd.web11.13047.1716986693089467150
 for <cip-dev@lists.cip-project.org>;
 Wed, 29 May 2024 05:44:54 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@renesas.com header.s=selector1 header.b=dFAFHqO4;
 spf=pass (domain: renesas.com, ip: 40.107.114.82, mailfrom: chris.paterson2@renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EefXlIgxYYtl5f8V9+GRPjnc9Z4gYtLcI85G9utG46cWZN9osAmhclKsez4SbJai1L9t5dDvTdHZMGGcRTkk2aG/7Fo4/vyzO8nItHPh75FPV0sz9ZQGQsx7xPLpiQfP4H6yFqRvEauTazgQa+8S+qCRgNna7tC9mk7sa3EWTt8TNqe97S37lvlwn7SPjen1bnki+CrMWhFOZpGq/AiGzTr8ZHY+fCQP7pES6KJvC/58RbMG9LNsGvuxkTueJs5MAqvQZjxdBQJyMYw/HfH3y7zQNBg2K1gjx/E5+5vRrTK0Wk8Yr84vgFnr7S83nftbWdk4e5k9L+jnkb+ViUJjRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XbrU2mxeWFZtRn7/Xgt46GhCrGYSvZWOwN+JMOrYISc=;
 b=ZsMsp/3vaeiH5a66lqnXWon+EfF6tY1MR2yhH0mMey4ooH4nZdzzKN1OLHxZoxD5l6yGDshi5Ht4AMhL0lCImp0ORmeAbJ7nba03iKPAigcnauZShNw4FAE5G4dc6qq+GRbpTz+GYsDwegxY1ww0vuI72h76VDhx4/HW9xAGwVp5TAgNE2maSnfdwivbMK2yXjHS4bLhTh8gl4o/Y5hEnwIwaOPLSR8g246Go0aozqaz5+Zb5jRhdou92sWqNl8fbi31h9pmcXUm/ENuQVzpRJOLmRA4B+vv+Tn+c5ylZojVYvCJBmIzMqk3LUQqM35xfl1pZI4917/N3zZSKJytkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XbrU2mxeWFZtRn7/Xgt46GhCrGYSvZWOwN+JMOrYISc=;
 b=dFAFHqO4H/FBGlmUp3WZxPEYnCwlGVa7Sg9LR8cWRuJdEgijA8DSult6zPT4dhJGqaF4Vepteszfwm064AXbUSYryy4kMgVTFqQl/08rjjp7y9zWTJuA8wd9JLR80UNW+NLDJ4aE1ErpToN+0ZpmTdOmCzzSFIz9FJa1myo5oWc=
Received: from TYWPR01MB11862.jpnprd01.prod.outlook.com (2603:1096:400:3fc::6)
 by TYCPR01MB11578.jpnprd01.prod.outlook.com (2603:1096:400:37e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.21; Wed, 29 May
 2024 12:44:46 +0000
Received: from TYWPR01MB11862.jpnprd01.prod.outlook.com
 ([fe80::1bc:6d4b:6770:82c9]) by TYWPR01MB11862.jpnprd01.prod.outlook.com
 ([fe80::1bc:6d4b:6770:82c9%3]) with mapi id 15.20.7633.017; Wed, 29 May 2024
 12:44:46 +0000
From: Chris Paterson <Chris.Paterson2@renesas.com>
To: "Sai.Sathujoda@toshiba-tsip.com" <Sai.Sathujoda@toshiba-tsip.com>
CC: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
	"kazuhiro3.hayashi@toshiba.co.jp" <kazuhiro3.hayashi@toshiba.co.jp>,
	"dinesh.kumar@toshiba-tsip.com" <dinesh.kumar@toshiba-tsip.com>
Subject: RE: Unable to start swtpm_start.sh
Thread-Topic: Unable to start swtpm_start.sh
Thread-Index: AdqxZjRcYVHYPZxaT7+kSAcinUMJhgAQCb5gAAE2fQAABUA6IA==
Date: Wed, 29 May 2024 12:44:46 +0000
Message-ID: 
 <TYWPR01MB11862523C4D2B3CBB9F34BF6BB7F22@TYWPR01MB11862.jpnprd01.prod.outlook.com>
References: 
 <OS3PR01MB610382522DF0932C7EB0CEB6C2F22@OS3PR01MB6103.jpnprd01.prod.outlook.com>
 <TYWPR01MB118625C09DB4B02CD05FF2A75B7F22@TYWPR01MB11862.jpnprd01.prod.outlook.com>
 <OS3PR01MB610375A3AF315A3A9995F563C2F22@OS3PR01MB6103.jpnprd01.prod.outlook.com>
In-Reply-To: 
 <OS3PR01MB610375A3AF315A3A9995F563C2F22@OS3PR01MB6103.jpnprd01.prod.outlook.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYWPR01MB11862:EE_|TYCPR01MB11578:EE_
x-ms-office365-filtering-correlation-id: f27ccc1b-49bb-43c8-1e45-08dc7fdd1efa
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|1800799015|366007|376005|38070700009;
x-microsoft-antispam-message-info: 
 =?iso-2022-jp?B?Z1N2Z2Qxc1Z4Ykc1bUNmelVmK05WdHRUMTY3SThnU2EzS1R1M2h3c2xB?=
 =?iso-2022-jp?B?RGs3VC9LOFRBZ1ZVS2RETjBmN21Eek1QdngvNVNBMUNaUXRvcU1MVU04?=
 =?iso-2022-jp?B?bkF0b1BET3NlcHA3U1RtV2hMdlJHbDRNTWIrUXFqUzFOTHR1TVdqUGdw?=
 =?iso-2022-jp?B?S2pBOHlSZFUvajQ5M0NyZWkvY3NEc1JpRjY1bmpsVXFUdklRMktpaDFH?=
 =?iso-2022-jp?B?S3owMXA3N0JiY2x2amREVnJBb2Y1SnlhaEQrVUluVnUwdzVHalhqd2dY?=
 =?iso-2022-jp?B?ZTJ5dWhmcXQ3aE5WcENqVU9sSGs4UHVyTC90bE14bDdSY3ZVbVJJMDMv?=
 =?iso-2022-jp?B?emgrUC9jT0xZRURTN0xoYXpOcjNpWkdMRlk2Vnc5NkEraVhyUzFua0VI?=
 =?iso-2022-jp?B?Y3kxZTZxdHZVVjhSc250SzFRTEtzMVJBK2MrWm9mbWZKbUZyZHBSbC94?=
 =?iso-2022-jp?B?eFhwWE5SVVFseVRUVDBTdTZLci9PZExoeHdDZmE5dmNNTkVvWGZwMGlV?=
 =?iso-2022-jp?B?clpZMGpQVDNvME56RVNGeEx0dDJaYk1CWG9xa29TNnMzNGpWTmRHZURB?=
 =?iso-2022-jp?B?K1UvSm94MGpSMERWd3RpUFVXRHZselhuVjBOMDVycjlxVWs2dVpSeWpK?=
 =?iso-2022-jp?B?ZkhreGNwa0JFcm10VWNVaVdpM1NoS1R0WFR6ckhhM3N1dkFQeFhiMTh2?=
 =?iso-2022-jp?B?YVZxQkhZRitNNTdvdzdINk1oQkRTL0d1c01RY0VLZ3ZZZTJFaTBXVzE1?=
 =?iso-2022-jp?B?RFpKV3c2MjhSWlVGNDMzemYyMkljQ3VFcW1ROHlMN2NNdHI1YjlpUlZu?=
 =?iso-2022-jp?B?dEVDZHo1Q2xnVTgzaTQzcEZCVjFPTis0Q2lCbEQ5VnlDWmlvU2VsUFJP?=
 =?iso-2022-jp?B?Y0pKS04rdEZEWlE4Szg3VTNrT2w4UDBtcXJKSnVoZjlpelNmWGdsbVlI?=
 =?iso-2022-jp?B?MXJSbVJuS3lPRFNqN0FwcGRnQlJOWHZMeENmcjJ3Z1hNVFpYMUZ4TVI0?=
 =?iso-2022-jp?B?N2pOOGtZaXJ3WGdxTzNzdXd2L01YUlhDQ0EweVBJT25RREFYNEsvRWY5?=
 =?iso-2022-jp?B?TzhHcHdKK0xLcHFUL01iMVZLYUpzcERFck5WUEFRRGpDdk9NZENwVGlU?=
 =?iso-2022-jp?B?bjgrS1BLNHF6ZS9tSTNNY0dGRzRLV0ViREpFS1RpbVdxQWN3Q2k2MS9S?=
 =?iso-2022-jp?B?OGhtQlpOdG5sNzJlZ1d6cmZXaXgvUGFveVlUVTJIQWFsMFM1ejNTalhB?=
 =?iso-2022-jp?B?SHZyZGVSeGwvRnhBZzdnaEZUU3lpZzE2aStaNHY5SmJoV2l2T1I1SWtH?=
 =?iso-2022-jp?B?d0pMeWxwTjcyeWdyek1hSkJvTDZRTGpMSWw5aFl3WDVtM0hvamVFVU9r?=
 =?iso-2022-jp?B?T094djFLbU9WV3RYcVVjRE1GRlJkWGpsUWRBVkVHWXE3SWFXaERoS0VO?=
 =?iso-2022-jp?B?V05PSEkyT0p6c2c5ZXlDSXljN2pWRUN4UGRUcHN2QlVOOG1ZUUJvT1N4?=
 =?iso-2022-jp?B?bXhRL0s0Ui9abi8yblVocEV5SGJjK2lDNlBuWVZ0SmtzVm8relVrb2cy?=
 =?iso-2022-jp?B?QkpNWVByVlRZeEJiaytQT1VhVVIzUUtCeWoxdU5jd3R1YS9lUWI0dnhs?=
 =?iso-2022-jp?B?dVFxYndNc3I4QlRzMm9yVm91MmR3azlpelE1ZEJGR3NrY3dvZGFnbk05?=
 =?iso-2022-jp?B?RkcxbzFpZFFGbkJtdHVVMmUyTXZwQ2FjQ2lUOVRwNVFEbGV6dE56ando?=
 =?iso-2022-jp?B?TkxCcWN5WVdXb0t5cTlEcGxjdVp4S3hVTmNnWS9uVGhOWEZrcVdpTjFS?=
 =?iso-2022-jp?B?V2M0VEdNNzVoS2ZjditOOUdEVjBUSlZFOE9Ra3F1NEI2SURJNm9CSzN3?=
 =?iso-2022-jp?B?PT0=?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB11862.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?RnRxOGJrUXErdkpxMmdTNEZvRXFCYUpOWWV4YTBIV2YxT0VSMklsbVFF?=
 =?iso-2022-jp?B?Wm5Fd3VIUTZBTm1ONjUvRmh6bUQxSnRTbEZrUmpoRmhhTDd4ZVc3MEky?=
 =?iso-2022-jp?B?eVpiYlgrOEIwalZ3RTRwZXpUWlFPYUJqRjFGaEpKdnpkcHlTbHBDeGhS?=
 =?iso-2022-jp?B?TTEza2UvZlpseTJpcGNIT2JnbDR4QUhiMjZ5VFpZUGQxWFN5Q05vbHgv?=
 =?iso-2022-jp?B?bCt5TEJEb2JXVDY5TGUxNTk5SlJMQ3BSZlhOYlcwb3M3ZXdXRjVVNEZO?=
 =?iso-2022-jp?B?ME41SlNobGFhSllQZlBkcHJRT2t5K2g2OUtFdW1Oc0NVSzhabEZnRElY?=
 =?iso-2022-jp?B?aTF1K2JCeDZNSU9qUENmSG9HYmM0Rks3VUdRNHl3OWZodnh2c3JYbGE2?=
 =?iso-2022-jp?B?VDJzbllSclRYOHhzN2ZVNVpqUmdreUQwazJ0azdRM1hCUEQ2NUJIaEFJ?=
 =?iso-2022-jp?B?K3NxckNNWEc3emlYdkRJVytuZFY1K09pb1NEanFXRzdibUp3cGMxR0dM?=
 =?iso-2022-jp?B?OVlrNzd3dmlPd2NnQWRYZ2k2a3lKT21ucnk1b3EwRjVoc0tSMjZsQm1z?=
 =?iso-2022-jp?B?YXFMVUhzZnFIb05SMGFBcDlmdG1vamRYbXdYQnRia0hPOUtZaWo2a1Ew?=
 =?iso-2022-jp?B?OFVXVTh2UlAxbUVaT3hvNk1YRW1YQlB2K1lLWTlSbTNaSUpZWXhRZExG?=
 =?iso-2022-jp?B?OWcrMW9HNG5FQkg0V2JrcVZuMXNqeDlOTXF6TjVXelRYdCsyb0ZSUUZI?=
 =?iso-2022-jp?B?a1BXZlJCMzZxdDNaRGJFazBOeEN1ZWRVMlBtMUdDY1o3YUpobk9iL05s?=
 =?iso-2022-jp?B?WEh4Und6THQ3bnVnZWJSMjgwa3dOZXVuaUY2SE02Skc4OEFMTnRxdEgz?=
 =?iso-2022-jp?B?TW0vRVp3b0dGTWkwNUhIQThwT0h2UFIrV3MyOUhjdEUvMGNvZHlOa3Vv?=
 =?iso-2022-jp?B?dU9vSUR3cEgzZnJ0ZWVBU2IwWWtjOFovMXlRMWVROVMxU0JoT094Q21u?=
 =?iso-2022-jp?B?N0RGQnJGSjU0eEt2UzNJU3lxR3E2bXBqVnIxTEw2R1JVVkwvTTdxK3VD?=
 =?iso-2022-jp?B?dVZ0ZkNWZFEvSXN5WitSd2drSmlhVTlKWisyWVZQY1oxVUpsbzMrV3NU?=
 =?iso-2022-jp?B?VG0xZDUzQmJ0U2ZiN1ZUVXFqUUNINzBMMHVOU1VwWmRZZ1VvTVVROU5o?=
 =?iso-2022-jp?B?dG92VVRLb2VWL29CcDFtRU9zODk1VkRzOVVyWXhRd2pveFVWaGx2N013?=
 =?iso-2022-jp?B?MjRsMzdWaTBKTUphd1AvMlpZU2FXcDdHWHRQTmJNTUVhTzh0M1dLVlMw?=
 =?iso-2022-jp?B?dmdZYkw1a21sNVF2N0FRdEpzWXgzTVIySWkrQnhGaUVNNThkeUxSRUp4?=
 =?iso-2022-jp?B?MEdhazVBTzhGNUFIZXNUS3hrNGNiSnZaNmxMQkJuWkI5bEJiZzArdzAv?=
 =?iso-2022-jp?B?b0xibkI1R0JqazVZYWJua1JyRjlGL05oOVdWc2pnTkUydWgrRWRzUkha?=
 =?iso-2022-jp?B?TDVvc1FIZWxYVHc4dWJqNlAxT3BkcEtCUEUwQ2x5WE5wVzZxQlpSWnpp?=
 =?iso-2022-jp?B?U29sdGJmbkg4Y05ieWdoU3BIandmMnZrcC8vMkJHTGRsZVpZMlorUE00?=
 =?iso-2022-jp?B?MkFkWW4yOEloRE1zTWNnSGt0TUFMZjJxZUJSUGcyOTdpcWQ2WkR2TStt?=
 =?iso-2022-jp?B?dWRCYWxzYlZIdnJXaWl2aHo4VmZ4TGFKQ2p5ODB1R1FpalY2USt6OVVT?=
 =?iso-2022-jp?B?Vk4wNW9uWGVCc3BwUE15RHJkVnBoUUd2WEowN1V3SEIxOTQzUTBKTWJW?=
 =?iso-2022-jp?B?c0VtYVlQd2RZbW9yT2FxdU5ESEc2RTlEQ1ZLdXVoS1ppY21nSkp3OU9L?=
 =?iso-2022-jp?B?Z05JbFk5S0R6NXhNNmh5OHZmUWFWVS8wN3ZEa1ZqdFNKRnhtZVJGK0g3?=
 =?iso-2022-jp?B?M0taMElocnRldlREbGk5aUhYNkc0SEJPVm54ZlEzaHZRd2JuVkJVVFBh?=
 =?iso-2022-jp?B?ZWhkZ3lIZzQ3VWJXZldmZzVGcUoyQ0tLeTAvL0w5eEFiSHIrSmo0bGV4?=
 =?iso-2022-jp?B?ZW1va1VaMURNbitBUDRYd0F1dTQ4YXZCenp5NGU2QlFwTmZvaFVlZEcw?=
 =?iso-2022-jp?B?ZXhxTUdJNEFnekhzT1lsK21TTkIvQTdtYjRSQW9mYm8zNndDOG9KU0JG?=
 =?iso-2022-jp?B?S1NLb1pVVlFXMW92TUJPem15YkV6L3dLVWF3ZWFxUm4zb2htQ3ppbUR1?=
 =?iso-2022-jp?B?TlJrbWpQU090M3hkZG5jYWdMMDBSd2ZpNDVqKzQ5cnlmcEZHTXpPSFdS?=
 =?iso-2022-jp?B?cmlGUnJ1NUIzMS9UU1dzRkpHZWp0NzdVVEE9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB11862.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f27ccc1b-49bb-43c8-1e45-08dc7fdd1efa
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 May 2024 12:44:46.3892
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Of9WLnKoCtrzrR8dLxQnEeZVdd2aTPy0oqgMzCyMb6Eo3i4sJJCkU6MkurKQSe2qmOBv8jyqAifJ/vR7SccQc7AgHIj4zh4tnRTKAo0p+MI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB11578
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 29 May 2024 12:44:59 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16064

Hi Sai,

It seems that LAVA needs some kind of output to the console when running th=
e user commands.
I've created an MR that adds some output, and also fixes a couple of other =
points:
https://gitlab.com/cip-project/cip-testing/lava-docker/-/merge_requests/39

Please can you take a look?


Kind regards, Chris

> -----Original Message-----
> From: Sai.Sathujoda@toshiba-tsip.com <Sai.Sathujoda@toshiba-tsip.com>
> Sent: Wednesday, May 29, 2024 10:35 AM
> To: Chris Paterson <Chris.Paterson2@renesas.com>
> Cc: cip-dev@lists.cip-project.org; kazuhiro3.hayashi@toshiba.co.jp;
> dinesh.kumar@toshiba-tsip.com
> Subject: RE: Unable to start swtpm_start.sh
>=20
> Hi Chris,
>=20
> Let me also debug this in my local setup parallelly.
>=20
> Thanks and regards,
> Sai Ashrith Sathujoda (T S I P)
>=20
> -----Original Message-----
> From: Chris Paterson <Chris.Paterson2@renesas.com>
> Sent: Wednesday, May 29, 2024 2:30 PM
> To: ashrith sai(=1B$B#T#S#I#P=1B(B) <Sai.Sathujoda@toshiba-tsip.com>
> Cc: cip-dev@lists.cip-project.org; hayashi kazuhiro(=1B$BNS=1B(B =1B$BOB9=
(=1B(B =1B$B#D#M#E=1B(B
> =1B$B!{#D#I#G""#M#P#S!{#M#P#4=1B(B) <kazuhiro3.hayashi@toshiba.co.jp>; di=
nesh
> kumar(=1B$B#T#S#I#P=1B(B TMIEC ODG Porting) <dinesh.kumar@toshiba-tsip.co=
m>
> Subject: RE: Unable to start swtpm_start.sh
>=20
> Hi Sai,
>=20
> > From: Sai.Sathujoda@toshiba-tsip.com <Sai.Sathujoda@toshiba-tsip.com>
> > Sent: Wednesday, May 29, 2024 2:29 AM
> >
> > Hi Chris,
> >
> >
> >
> > After the scripts were included and device dictionary changes were
> > made to
> > qemu-renesas-01 and qemu-patersonc-01. I tried to run the jobs, but
> > swtpm_start.sh  is unable to return 0 as it was doing previously which
> > is making the job get stuck until time out. LAVA | Scheduler | Jobs |
> > 1139794
> > (ciplatform.org) <https://lava.ciplatform.org/scheduler/job/1139794>  .
> >
> >
> >
> > In the end it is also mentioning that it is an infrastructure error
> > and to report it to LAVA admins. For comparison here is a successful
> > job which ran recently on qemu-renesas-01 with your manual changes. ->
> > LAVA | Scheduler | Jobs | 1132059 (ciplatform.org)
> > <https://lava.ciplatform.org/scheduler/job/1132059>  .  Previously in
> > your manual changes to Renesas slave, there used to =1B$B!H=1B(Becho $?=
=1B$B!I=1B(B instead
> > of return
> > 0 here
> > https://gitlab.com/cip-project/cip-testing/lava-docker/-/blob/cip-
> > lava-docker/lava-slave/scripts/swtpm_start.sh#L18
> > <https://gitlab.com/cip-
> > project/cip-testing/lava-docker/-/blob/cip-lava-docker/lava-
> > slave/scripts/swtpm_start.sh#L18>  which made swtpm start successfully
> > but that should not make any difference, right ?
>=20
> So the script works as expected in your local environment, but not in
> LAVA?
> I'm not sure why this would be the case TBH.
> I'll have to do some debugging.
>=20
> Chris


