Return-Path: <adithya.balakumar@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65A48E9127E
	for <webhook@archiver.kernel.org>; Thu,  5 Feb 2026 07:01:49 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.131])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.15305.1770274903638783649
 for <cip-dev@lists.cip-project.org>;
 Wed, 04 Feb 2026 23:01:44 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.131, mailfrom: adithya.balakumar@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1120) id 61571f6K2066454; Thu, 5 Feb 2026 16:01:41 +0900
X-Iguazu-Qid: 2rWh8deQPDBR7GVYL4
X-Iguazu-QSIG: v=2; s=0; t=1770274901; q=2rWh8deQPDBR7GVYL4; m=2WefNJ6oNzIADUH3wPQJTeDZRv02S2PYXHPaddA1pMQ=
Received: from imx12-a.toshiba.co.jp (unknown [38.106.60.135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	 id 4f67S45S8Wz4vym; Thu,  5 Feb 2026 16:01:40 +0900 (JST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jQyLS//kv5BvcUxPZHzcLYal43boBSgguNXLrCGSo/v1Zn3RwHa8MN0SU4Ax0p1oKYRwAv3srMKYmj67NV9tt31L3phP7jPpTY1aqmtftMUaGgq57zBB32Da1+CjKLC9+eJ087Ch8GTCOKv2/FUmpl76cKTC13vB+54OQI4RaZw9ZRCYdM9KjywV5bj1Jlg49xTE7MNwIaJFUsds/zM5wFdxnPweHiUx4bo3mXSTC6Qfsh8k2NPUp9j7CiKj298GGZSSJd3Myg3e7JgsBz4zlTXf7sb8yFnijcXD0qpWgzOTCY8IHC2hM2m69wJcgOye3Occ/1q/xhTVLELVCYqbpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cqyj68MySa/72ex8gMJjBuoDoRFcQ2xgkGQL3kossTQ=;
 b=bP7wtqNkj9ZjBD0yyJWam4Zm5hdHrIsBKXLe3t0KD6z7WI9s3Vu4XEWc3XDO+fRiveftxE3a8NcFH9cqwnZXgrgDLTPr2KKjPy+D+E2JybJrWLHTZfAw6F4GRvcg3YqsXHjjzG3eTMxzZ/xg7AwkLiIxtqkPiJ6cZQkNIgOUSqTvZbWBfyMRrMPdYmb7t3ND1OICuzEfJlNLIR0ZWJS/jPUNDfK8cynL3pVGVOLMhhAKRghniZwlpVTY3/6aOc0y348xvhin8fpXfiBhaPF/tz8ChxSfAMWHtPvYvk7dMgjNkkTkRWRKSNva9GKZKF2Usv1x5SsOzADoo1tlgKmyxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba-tsip.com; dmarc=pass action=none
 header.from=toshiba-tsip.com; dkim=pass header.d=toshiba-tsip.com; arc=none
From: <Adithya.Balakumar@toshiba-tsip.com>
To: <jan.kiszka@siemens.com>, <cip-dev@lists.cip-project.org>,
        <quirin.gylstorff@siemens.com>
CC: <Shivanand.Kunijadar@toshiba-tsip.com>, <dinesh.kumar@toshiba-tsip.com>,
        <koshiro.onuki.h55@mail.toshiba>, <kazuhiro.hayashi.f74@mail.toshiba>
Subject: Re: [isar-cip-core][PATCH v1] doc/README.factory-reset.md: Minor
 corrections, verification steps and what to look for during factory reset
Thread-Topic: [isar-cip-core][PATCH v1] doc/README.factory-reset.md: Minor
 corrections, verification steps and what to look for during factory reset
Thread-Index: AQHcllhDClDLOtNixUueGOZEYXz6cbVzqa4AgAAD2V0=
Date: Thu, 5 Feb 2026 07:01:35 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TYCPR01MB96693C40CB49321A6A982A32C499A@TYCPR01MB9669.jpnprd01.prod.outlook.com>
References: <20260205044638.14716-1-Adithya.Balakumar@toshiba-tsip.com>
 <a2cb468e-9aad-45ca-ae41-233c410f403f@siemens.com>
In-Reply-To: <a2cb468e-9aad-45ca-ae41-233c410f403f@siemens.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba-tsip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYCPR01MB9669:EE_|OS9PR01MB14171:EE_
x-ms-office365-filtering-correlation-id: b460a1ac-9fa6-4faa-560b-08de6484668d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|1800799024|366016|376014|14052099004|38070700021|8096899003|7053199007|95630200002;
x-microsoft-antispam-message-info: 
 =?iso-2022-jp?B?MVYzWGtvYWVWclR5SzU5WmpxZS8rRGg3elptQXcwYTBIMlpoUzJEUWVu?=
 =?iso-2022-jp?B?U0N3aGlqY1FlLzNma3l0Y3NMSVpXK1B5VDlYTVNNVTJGdWN3QnJoUk5P?=
 =?iso-2022-jp?B?c0dQKzVhZU9yUmtrVGhVRWZ2MW5tRHpuZFFtbG9zT0dVckhrRXFZM09v?=
 =?iso-2022-jp?B?NVFWZTZHT0VnQXBFZEN1MXp6WnZBeDFGbkNSZnBYZDRBcnh1MzRWaldY?=
 =?iso-2022-jp?B?UmlYU2NJNmcxRXBoWUZIdE5zZ0JycDFabXA3azkyb0pycFVicXZQMCtL?=
 =?iso-2022-jp?B?OTZVU0NSVG8xZmNzSnZBMmgveGJ6VkJYSGMwc1orOVNuOG5GZEdzWWFi?=
 =?iso-2022-jp?B?N1lrZDF6bmVGbnl4dG5KdlVuai92QTBHcEIvdjZqN2J1WFhjWjlwYjNH?=
 =?iso-2022-jp?B?T0IreUZ0cnVlYnlpUS94MDAvZ3hIcVhLcC9RM3ZldUpwL0FQU2NtTnds?=
 =?iso-2022-jp?B?RXY3RHZTK25zOU1KdFRudHlqWEx6OXY0UjJZNmlrSmxoV0ZkTEExZlJL?=
 =?iso-2022-jp?B?akpsWlIzdVJXRHJ6ZjBVSkMyZSt0amxBaVY5NkoxSWJySlNjT2xJeDNB?=
 =?iso-2022-jp?B?MG03bm5KRXdiOU9FQWN2WFlnYUI3Ri9TVlllZElqNFNGSWZjREJsSjdK?=
 =?iso-2022-jp?B?UEgyTnhDV3dYSkJoOFRqUFhJUUpmeVo5eUpSOXNoMjVUaG9QeXNheWVN?=
 =?iso-2022-jp?B?OUZyTGRWYmF1VHpZOFdMRm80Z3pVbHhxZ0pJbks1QWUxZjNEbHRsSnc0?=
 =?iso-2022-jp?B?RHgzWStDekh0N051blJ1eWIxU0dJelFmTkZkdVcwRnFxWmhBY0V4S3p4?=
 =?iso-2022-jp?B?YWpiQzF3TExNTTFMYTEwV09xMzI3Mlp3UnRrSFpMWlZUNUhwZHQ0cjFU?=
 =?iso-2022-jp?B?KzluT0tya3V1NEM5Z3JOQjNLcitwL25HNUdqaUp6dDdtV3FpcWtBZU93?=
 =?iso-2022-jp?B?anptM2E5ems5RXh2c1p2Nmo5N2lQQWxqQUlSdVZ4cTFOYXlXbko1N3Rp?=
 =?iso-2022-jp?B?V3BST3oweHlnN1NrSzg3cnVPTEdiYnZDMnNOREw4UGphQmx6RDlUbUds?=
 =?iso-2022-jp?B?eWw0YUN4N3dZenZjMEw1dVZ4QVdtakM2NGpFYUFkaXA4NWVTUTAwOUtp?=
 =?iso-2022-jp?B?ejRrZW1sendYamZUZFVUeE14dDg0VkIrM2lXR3RabmtiUGVUYm9HOU51?=
 =?iso-2022-jp?B?ZFRrTWVralBqWGtmeExPT0RNUzA4eVkwNEVGTGxOUlA3bjF5d3RleC9J?=
 =?iso-2022-jp?B?Zm1pQ0N3Z2lsL04rREN3UWNybExUUnVYaGN2UUFhWi9jL2s5VzVtZSts?=
 =?iso-2022-jp?B?bkt0WTFLR2Zsc3h5QWFhKzY5Zmdyc3dQck1hLyt5NUM3dnFEWkdjMXZu?=
 =?iso-2022-jp?B?QUtkeE02SHZDcVE0dktpdk1iVFNrc2xqYXRlanM0TFF0ZFJmbzI2czNH?=
 =?iso-2022-jp?B?aUg3UTdPUEp5OVhWYWtIcVlEeW9LYjRLT1gvc3c0TUFLWS9vTVdEdjBN?=
 =?iso-2022-jp?B?T1FZczl2OUtrWWRBNmRIZWxjNU5MRFhqU3ZsVUxiNDdreS9ORUExZjlO?=
 =?iso-2022-jp?B?RjNYcEFzd0d1NjU1L0ltYndIK3VYWi9LaFFPemdORCtSckRqVUY4SjJu?=
 =?iso-2022-jp?B?Rnkxck1aemExai9vaWFvaGtxS2pRV0gvV0dULzFSa3Q5VExzTkZ3cllE?=
 =?iso-2022-jp?B?cGwvVytiRWxKYjFJWVg3cDZ4OTBGMExoTHh3SEU0Y201dWllOU9ZVUEz?=
 =?iso-2022-jp?B?MDVhb1B0Q2pnQWVLbDJoWUJtK09zOXlvVDhGKzNGbHJIZFZEVlo5VE5U?=
 =?iso-2022-jp?B?NksveVdWNDRTMEZTL1Z4Wjg2M3U5ak1NbVlHbXlieGlKQXdZbUxsNzJ4?=
 =?iso-2022-jp?B?amcrMmhwTFoyRjg0UzBLRDh2STJiWXU2YnRDekJyd21aamtMdDhsVnVX?=
 =?iso-2022-jp?B?TVR3dDVySE5aQk4wWEw5VS9oK3J2WmJRQkNGSzNJYy8xMEowYXFBbUFL?=
 =?iso-2022-jp?B?WEQrUkMvVjdXb21zTm5TRWdnOHY4OW9JKzF6SW83VWFaK0pjemlEZ2lZ?=
 =?iso-2022-jp?B?Q3M4Z1ZLb0lLMU1rYnd0eW9DRUx0RUdvVmViQXdOcVowVGdDUHN4d2hv?=
 =?iso-2022-jp?B?cERpUi83blVxT1FJUDNxMWdNemx0ZkFoampsaDltcFhrZExHL1B1LzdE?=
 =?iso-2022-jp?B?bkhZOXNFWXRJWENBdGpGdWgxbEMydnlnRnBQeW1ZczZxYUlGZHVXUU1Q?=
 =?iso-2022-jp?B?VUthU0ZZaTdSSWc0TEt0TWZKSElhWHpGbDRIRS8rY0x3Zy92WlR4cVFY?=
 =?iso-2022-jp?B?eDlYU2hyMWJleS9xaTRuSUVXOUJSUEJyN3JhbHFBZ2JwZDliZkxDMGF5?=
 =?iso-2022-jp?B?SkJiTU8rUnRMK05Jd2IxMCtLcitIWjZjTE9COFpEZ3JVcXQzQWF2U3dh?=
 =?iso-2022-jp?B?QlV2b2hBPT0=?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB9669.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(14052099004)(38070700021)(8096899003)(7053199007)(95630200002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?MGZPQm1vOWU2WVpYM1dxanlXOFc4cU51TThPWFFXcE1mV1VlUVMzY25M?=
 =?iso-2022-jp?B?Q0NwbVlWY0pyKzRuR0dNeTZtN2dMdU9TWmxQVGVpcVowUmtjMG83bGpu?=
 =?iso-2022-jp?B?RTZhZVVkU3VVZDlkVnpHdlkweE1rZ1ltTFpmaC92b2QwUTFscFFjUHpV?=
 =?iso-2022-jp?B?WC82QWZqYW54UUc3QnU3cFVRN2d1SkJ6SW4yWmZzeUpaSWQ3QkYzOE9Y?=
 =?iso-2022-jp?B?MmlkVk4xK204Sm5ybjVRc05GR21UQ2p5L1hYTTdHS1JjZmtSR1dlYnVX?=
 =?iso-2022-jp?B?VlVaQTF0bWowTklNQnd0emZCMVBaYWFCTmk5UW5kenAyOFpZNzhYQUJN?=
 =?iso-2022-jp?B?MlZ5WWtQN1I4WlRZekJvQmR6WHp2ZkRZYVV6eTZjZXIvNTNvR2tGSjB1?=
 =?iso-2022-jp?B?bkRJZ2xHcnRXT25QMk9HOHYwQUtuWVg3QlZ4NFR2ZzNJUXl6K2pnTDlq?=
 =?iso-2022-jp?B?MS96UkxVZnZobktvWWozWmdsTVBpcVFGSGlBVjRNdjNRaVArbElOaEkz?=
 =?iso-2022-jp?B?djkxbEdvOFMzS25WMWNFZWNiR2gyNGo4ZWo4N2RLdkNFU1pTY2d2bzBN?=
 =?iso-2022-jp?B?K3ZaMWl6ZnVyZTdaQnpsSElnSmwrdnNETUlKUGt3bUR6MllCMnZhQUdl?=
 =?iso-2022-jp?B?RnplSHRZNiswQ2MrYkpzejVSOGNIRUUyRXd3Tkt0NmJmbHV6RjdDSTlo?=
 =?iso-2022-jp?B?ZlNFbEMxRHgwODdsTmVSMEt6dE5WTlNMQWdpS1VBcU9GeEovYmdzTWdM?=
 =?iso-2022-jp?B?Y2M4YUF3R2VZM0lHaytRMEM0eHA0bnlGZmh0MFdhRTBpenphMEFKR0R4?=
 =?iso-2022-jp?B?ZHJxZ2Z5QSsrZHhDK0o1cWkrbTkrTENtcG9uVWRQOEJFMWxsaXc3NWd2?=
 =?iso-2022-jp?B?RTNkN29lbUdxR29iWk1zUmx0NkhvNUd4SlRhM093R0pQb1dCemRjYUFG?=
 =?iso-2022-jp?B?ajRJZXJTYitONzVYYXdOdGFjd0JEUGpKTmE2VnF6UUZobU1qTWI2Sysx?=
 =?iso-2022-jp?B?Unc0SjVYSlJvVzZ4MEVqOStCdmFIczJFRHBHK3lhK3VvdGV3YngxZ29K?=
 =?iso-2022-jp?B?SVJBR1EzR0h5QTJhclJsaFpycWhtc3YwZXRqaWp0bE95Z3ZMZThhc1gx?=
 =?iso-2022-jp?B?N3ZsTGh4azlIbG1Va0NiaEh0WTVwUmcrTytSdFVPS3poREx1SXVZb0V4?=
 =?iso-2022-jp?B?TGl4M3ZHUnFzc3hHWjNkMDRURGRzZ2pwNFRsRUsyTnUrQUFnVmlDVmFT?=
 =?iso-2022-jp?B?ZzkvZDc1RElhS1JaOHg5aktieloxVmpFbWlPVVRBQklTRHBBSnN2ZXRB?=
 =?iso-2022-jp?B?Vm9BYkNiM0Y3RUhXeXpiRGlLWitNZDFXSVNnYXVFdUFZSnRxallyK3M2?=
 =?iso-2022-jp?B?Qk1Jb2tScWlNbzA2QW10YkhVd29ab1pMREpwS1JIMGx2L25zTFh0SzNB?=
 =?iso-2022-jp?B?TG9MWkdhYnpKaVEwMEtLY0tIMTZHSGx6RndzT3drQnFJbTVZSWtiV0ow?=
 =?iso-2022-jp?B?eVBrbzQ3czRscGoxeWN0TXQwQ3pSTDVSZGZwUHczaUtVRVR5S2dPbW1U?=
 =?iso-2022-jp?B?aGpMeUR2c0xWcXQwK3FYeGZOSzhJK1ExV3dIZDhYOG9McyswdkN0UWhu?=
 =?iso-2022-jp?B?VWtFVUo5WFBTSjdBNkxrWWZhbE5sVXdZZ0JXdkdvWmlvOUErTFVYQlo3?=
 =?iso-2022-jp?B?TVZlMEJscU8wQUV2bkRIZ1dWTlUyTms4aE0yeUkxakhNanEwNU4yaDlU?=
 =?iso-2022-jp?B?UnF1OW1UcnBwSy9GSVArS2QyUSt1SjJVdkZWeEl6Z1ZxOVRoR3YwQ0pI?=
 =?iso-2022-jp?B?T1FLd0h4aFRLTDgxZWJaem9hZnJuM0hGNTF4YkxsbkR0WGZia1dXYXpO?=
 =?iso-2022-jp?B?Yk1GenRzYmtaY1Fpd25yWFl3blA4UGhuc0RJRTZ6QlZiV3NCQ3UvU0JX?=
 =?iso-2022-jp?B?Qit2R09CNFJwN1JwUDdGc0pjV3RLSUxqeUNpNVMzTU9RTmpEeGFkb3hV?=
 =?iso-2022-jp?B?MHZzbWVyUFBrVzVYaHJKQ0dxb3pIa0RnYzJobDQ0MTdvRnUzcEpjM1Nt?=
 =?iso-2022-jp?B?MjQ3cW8yM2tENDdxajRLTGlLWXZucXZxNk5meEpMdVROUkpsbXM3ak9M?=
 =?iso-2022-jp?B?R3RhQlNIV2d6OTJiYXlpdUUwUkIzaEVRSU0wM0YyRlNCZkw3bTBtdnI1?=
 =?iso-2022-jp?B?U2VMeitPYm9zemJMYlhtLzVQMVE2RDg1bmdDODN1UHFaOGYwSWRHTHND?=
 =?iso-2022-jp?B?YVJNZ0lJRnFjRndzQVNxcDN0SFpONmQwTWFzUUpsSmg5VFN0bkhZUHNv?=
 =?iso-2022-jp?B?TTlrN21udGtrcG1YS3E3emsyNnhobUMrL29SRW8yVW1mRUdDUWZETVkr?=
 =?iso-2022-jp?B?UTY2a1NxMXVZUlVJYVVkN0dqT0NCNUtkTWp6M0R3NEJlT0FhTzlMVUM4?=
 =?iso-2022-jp?B?N2d6ZU5FQ1V4c0lMcWI3azdEcE41bndtZ1hpcGxKRUQyZHpIK2RCZjc5?=
 =?iso-2022-jp?B?THFnS3J3dWtXTklTQk9ObmhwTnBzdE5ubS90QkE3aTlhK2QvOG1KNVMz?=
 =?iso-2022-jp?B?WW9rd2wydz0=?=
Content-Type: multipart/alternative;
	boundary="_000_TYCPR01MB96693C40CB49321A6A982A32C499ATYCPR01MB9669jpnp_"
MIME-Version: 1.0
X-OriginatorOrg: toshiba-tsip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB9669.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b460a1ac-9fa6-4faa-560b-08de6484668d
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Feb 2026 07:01:35.1184
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZEfpIFjsB0DRAy5m3LC2TTb5WoFj2SG119y3u4atPtGUBqKMhMMqoSdHCuPDOHrhNv8mShZgmU0/ml4DVBc3Nj4c9VsoiyM+vp4W9pFnDux8euq4GPkc3BzZDJtwr9OD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS9PR01MB14171
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 05 Feb 2026 07:01:49 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21833

--_000_TYCPR01MB96693C40CB49321A6A982A32C499ATYCPR01MB9669jpnp_
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable

Thanks Jan, will make the corrections in v2.

Regards,
Adithya Balakumar
________________________________
From: Jan Kiszka <jan.kiszka@siemens.com>
Sent: Thursday, February 5, 2026 12:16 PM
To: balakumar adithya(=1B$B#T#S#I#P=1B(B =1B$B#D#I#T#C!2#D#I#T=1B(B-=1B$B#O=
#S#T=1B(B) <Adithya.Balakumar@toshiba-tsip.com>; cip-dev@lists.cip-project.=
org <cip-dev@lists.cip-project.org>; Quirin Gylstorff <quirin.gylstorff@sie=
mens.com>
Cc: kunijadar shivanand(=1B$B#T#S#I#P=1B(B DITC_DIT-OST) <Shivanand.Kunijad=
ar@toshiba-tsip.com>; dinesh kumar(=1B$B#T#S#I#P=1B(B DITC_DIT-OST) <dinesh=
.kumar@toshiba-tsip.com>; onuki koshiro(=1B$BBgH4=1B(B =1B$B8v;JO/=1B(B =1B=
$B""#D#I#T#C!{#C#P#T=1B(B) <koshiro.onuki.h55@mail.toshiba>; hayashi kazuhi=
ro(=1B$BNS=1B(B =1B$BOB9(=1B(B =1B$B""#D#I#T#C!{#C#P#T=1B(B) <kazuhiro.haya=
shi.f74@mail.toshiba>
Subject: Re: [isar-cip-core][PATCH v1] doc/README.factory-reset.md: Minor c=
orrections, verification steps and what to look for during factory reset

On 05.02.26 05:46, Adithya.Balakumar@toshiba-tsip.com wrote:
> From: Adithya Balakumar <Adithya.Balakumar@toshiba-tsip.com>
>
> Signed-off-by: Adithya Balakumar <Adithya.Balakumar@toshiba-tsip.com>
> ---
>  doc/README.factory-reset.md | 44 ++++++++++++++++++++++++++++++++++---
>  1 file changed, 41 insertions(+), 3 deletions(-)
>
> diff --git a/doc/README.factory-reset.md b/doc/README.factory-reset.md
> index 729912b..ef35225 100644
> --- a/doc/README.factory-reset.md
> +++ b/doc/README.factory-reset.md
> @@ -1,18 +1,18 @@
>  # Enable Factory-reset
>
>  To enable the factory-reset functionality the following two elements nee=
d to be installed:
> - - initramfs-factory-reset-hook which executes the factory-reset
> +  - initramfs-factory-reset-hook which executes the factory-reset
>    ```
>    INITRAMFS_INSTALL +=3D "initramfs-factory-reset-hook"
>    ```
> -- factory-reset-helper which provides the helper scripts to set the fact=
ory-reset marker
> +  - factory-reset-helper which provides the helper scripts to set the fa=
ctory-reset marker

The indention of items were inconsistent, but do they have to be 2
spaces? Below, you do not indent at all.

>    ```
>    IMAGE_INSTALL +=3D "factory-reset-helper"
>    ```
>
>  ## Technical details
>
> -The by executing `set-factory-reset.sh --create` a marker is stored as a=
 EFI variable or on disk (default `/dev/disk/by-partlabel/efi`).
> +The by executing `set-factory-reset.sh --create` a marker is stored as a=
 EFI variable or on disk (default `/dev/disk/by-partlabel/var`).

"The by..." still doesn't read smoothly.

>  The marker on disk is intended for devices which do not provide the faci=
lities to set EFI variables.
>  The initramfs reads this marker and formats the hard-drives provided by =
the variable `INITRAMFS_FACTORY_RESET_DEVICES`.
>  The initramfs-hook will try to detect the previous used file system and =
will format the partition with the detected type.
> @@ -27,3 +27,41 @@ The removal of the TPM keys can be deactivated by sett=
ing the variable `INITRAMF
>  As the factory-reset is executed before the disks are unlocked in the in=
itramfs, the file system type must be provided with the
>  variable `INITRAMFS_FACTORY_RESET_LUKS_FORMAT_TYPE`. The factory-reset o=
f encrypted partition is not supported with the file based
>  marker.
> +
> +## Verification
> +
> +- Set the factory-reset marker with the below command:
> +```
> +root@demo:~# set-factory-reset.sh --create
> +```
> +
> +- Trigger a reboot as factory-reset happens in the initramfs step:
> +```
> +root@demo:~# reboot
> +```
> +
> +- Factory reset runs during the initramfs. The reset scripts format the =
target partition with the required filesystem. This can be observed in the =
boot logs similar to the example below:
> +```
> +.
> +.
> +Begin: Factory Reset ... Begin: Reset device: /dev/disk/by-partlabel/var=
 ... [    5.834137] random: crng init done
> +mke2fs 1.47.2 (1-Jan-2025)
> +Discarding device blocks: done
> +Creating filesystem with 131072 4k blocks and 32768 inodes
> +Filesystem UUID: d4ec21bc-988b-41f8-8e71-4d2b24cb7074
> +.
> +.
> +```
> +
> +- If disk encryption is enabled, apart from the formatting of the target=
 partition as stated above, the initramfs scripts also encrypts the target =
partitions. This too can be observed in the boot logs similar to the exampl=
e below:
> +```
> +.
> +.
> +Device /dev/sda6 is not a valid LUKS device.
> +[    8.375556] tpm2_policypcr (224) used greatest stack depth: 11736 byt=
es left
> +persistent-handle: 0x81080001
> +action: persisted
> +Begin: Encryption of /dev/sda6 ... var: 12/32768 files (0.0% non-contigu=
ous), 6385/131072 blocks
> +.
> +.
> +```

Adding Quirin to help with cross-checking.

Thanks,
Jan

--
Siemens AG, Foundational Technologies
Linux Expert Center

--_000_TYCPR01MB96693C40CB49321A6A982A32C499ATYCPR01MB9669jpnp_
Content-Type: text/html; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-2022-=
jp">
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
Thanks Jan, will make the corrections in v2.</div>
<div><br>
</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
Regards,</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
Adithya Balakumar<span style=3D"font-family: Calibri, Arial, Helvetica, san=
s-serif; font-size: 12pt; color: rgb(0, 0, 0);"><br>
</span></div>
<hr style=3D"display: inline-block; width: 98%;">
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<b>From:</b>&nbsp;Jan Kiszka &lt;jan.kiszka@siemens.com&gt;<br>
<b>Sent:</b>&nbsp;Thursday, February 5, 2026 12:16 PM<br>
<b>To:</b>&nbsp;balakumar adithya(=1B$B#T#S#I#P=1B(B =1B$B#D#I#T#C!2#D#I#T=
=1B(B-=1B$B#O#S#T=1B(B) &lt;Adithya.Balakumar@toshiba-tsip.com&gt;; cip-dev=
@lists.cip-project.org &lt;cip-dev@lists.cip-project.org&gt;; Quirin Gylsto=
rff &lt;quirin.gylstorff@siemens.com&gt;<br>
<b>Cc:</b>&nbsp;kunijadar shivanand(=1B$B#T#S#I#P=1B(B DITC_DIT-OST) &lt;Sh=
ivanand.Kunijadar@toshiba-tsip.com&gt;; dinesh kumar(=1B$B#T#S#I#P=1B(B DIT=
C_DIT-OST) &lt;dinesh.kumar@toshiba-tsip.com&gt;; onuki koshiro(=1B$BBgH4=
=1B(B =1B$B8v;JO/=1B(B =1B$B""#D#I#T#C!{#C#P#T=1B(B) &lt;koshiro.onuki.h55@=
mail.toshiba&gt;; hayashi kazuhiro(=1B$BNS=1B(B =1B$BOB9(=1B(B =1B$B""#D#I#=
T#C!{#C#P#T=1B(B) &lt;kazuhiro.hayashi.f74@mail.toshiba&gt;<br>
<b>Subject:</b>&nbsp;Re: [isar-cip-core][PATCH v1] doc/README.factory-reset=
.md: Minor corrections, verification steps and what to look for during fact=
ory reset
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-size: 11pt;">On 05.02.26 05:46, Adithya.Balakumar@toshib=
a-tsip.com wrote:<br>
&gt; From: Adithya Balakumar &lt;Adithya.Balakumar@toshiba-tsip.com&gt;<br>
&gt;<br>
&gt; Signed-off-by: Adithya Balakumar &lt;Adithya.Balakumar@toshiba-tsip.co=
m&gt;<br>
&gt; ---<br>
&gt;&nbsp; doc/README.factory-reset.md | 44 +++++++++++++++++++++++++++++++=
+++---<br>
&gt;&nbsp; 1 file changed, 41 insertions(+), 3 deletions(-)<br>
&gt;<br>
&gt; diff --git a/doc/README.factory-reset.md b/doc/README.factory-reset.md=
<br>
&gt; index 729912b..ef35225 100644<br>
&gt; --- a/doc/README.factory-reset.md<br>
&gt; +++ b/doc/README.factory-reset.md<br>
&gt; @@ -1,18 +1,18 @@<br>
&gt;&nbsp; # Enable Factory-reset<br>
&gt;&nbsp;<br>
&gt;&nbsp; To enable the factory-reset functionality the following two elem=
ents need to be installed:<br>
&gt; - - initramfs-factory-reset-hook which executes the factory-reset<br>
&gt; +&nbsp; - initramfs-factory-reset-hook which executes the factory-rese=
t<br>
&gt;&nbsp;&nbsp;&nbsp; ```<br>
&gt;&nbsp;&nbsp;&nbsp; INITRAMFS_INSTALL +=3D &quot;initramfs-factory-reset=
-hook&quot;<br>
&gt;&nbsp;&nbsp;&nbsp; ```<br>
&gt; -- factory-reset-helper which provides the helper scripts to set the f=
actory-reset marker<br>
&gt; +&nbsp; - factory-reset-helper which provides the helper scripts to se=
t the factory-reset marker<br>
<br>
The indention of items were inconsistent, but do they have to be 2<br>
spaces? Below, you do not indent at all.<br>
<br>
&gt;&nbsp;&nbsp;&nbsp; ```<br>
&gt;&nbsp;&nbsp;&nbsp; IMAGE_INSTALL +=3D &quot;factory-reset-helper&quot;<=
br>
&gt;&nbsp;&nbsp;&nbsp; ```<br>
&gt;&nbsp;<br>
&gt;&nbsp; ## Technical details<br>
&gt;&nbsp;<br>
&gt; -The by executing `set-factory-reset.sh --create` a marker is stored a=
s a EFI variable or on disk (default `/dev/disk/by-partlabel/efi`).<br>
&gt; +The by executing `set-factory-reset.sh --create` a marker is stored a=
s a EFI variable or on disk (default `/dev/disk/by-partlabel/var`).<br>
<br>
&quot;The by...&quot; still doesn't read smoothly.<br>
<br>
&gt;&nbsp; The marker on disk is intended for devices which do not provide =
the facilities to set EFI variables.<br>
&gt;&nbsp; The initramfs reads this marker and formats the hard-drives prov=
ided by the variable `INITRAMFS_FACTORY_RESET_DEVICES`.<br>
&gt;&nbsp; The initramfs-hook will try to detect the previous used file sys=
tem and will format the partition with the detected type.<br>
&gt; @@ -27,3 +27,41 @@ The removal of the TPM keys can be deactivated by s=
etting the variable `INITRAMF<br>
&gt;&nbsp; As the factory-reset is executed before the disks are unlocked i=
n the initramfs, the file system type must be provided with the<br>
&gt;&nbsp; variable `INITRAMFS_FACTORY_RESET_LUKS_FORMAT_TYPE`. The factory=
-reset of encrypted partition is not supported with the file based<br>
&gt;&nbsp; marker.<br>
&gt; +<br>
&gt; +## Verification<br>
&gt; +<br>
&gt; +- Set the factory-reset marker with the below command:<br>
&gt; +```<br>
&gt; +root@demo:~# set-factory-reset.sh --create<br>
&gt; +```<br>
&gt; +<br>
&gt; +- Trigger a reboot as factory-reset happens in the initramfs step:<br=
>
&gt; +```<br>
&gt; +root@demo:~# reboot<br>
&gt; +```<br>
&gt; +<br>
&gt; +- Factory reset runs during the initramfs. The reset scripts format t=
he target partition with the required filesystem. This can be observed in t=
he boot logs similar to the example below:<br>
&gt; +```<br>
&gt; +.<br>
&gt; +.<br>
&gt; +Begin: Factory Reset ... Begin: Reset device: /dev/disk/by-partlabel/=
var ... [&nbsp;&nbsp;&nbsp; 5.834137] random: crng init done<br>
&gt; +mke2fs 1.47.2 (1-Jan-2025)<br>
&gt; +Discarding device blocks: done<br>
&gt; +Creating filesystem with 131072 4k blocks and 32768 inodes<br>
&gt; +Filesystem UUID: d4ec21bc-988b-41f8-8e71-4d2b24cb7074<br>
&gt; +.<br>
&gt; +.<br>
&gt; +```<br>
&gt; +<br>
&gt; +- If disk encryption is enabled, apart from the formatting of the tar=
get partition as stated above, the initramfs scripts also encrypts the targ=
et partitions. This too can be observed in the boot logs similar to the exa=
mple below:<br>
&gt; +```<br>
&gt; +.<br>
&gt; +.<br>
&gt; +Device /dev/sda6 is not a valid LUKS device.<br>
&gt; +[&nbsp;&nbsp;&nbsp; 8.375556] tpm2_policypcr (224) used greatest stac=
k depth: 11736 bytes left<br>
&gt; +persistent-handle: 0x81080001<br>
&gt; +action: persisted<br>
&gt; +Begin: Encryption of /dev/sda6 ... var: 12/32768 files (0.0% non-cont=
iguous), 6385/131072 blocks<br>
&gt; +.<br>
&gt; +.<br>
&gt; +```<br>
<br>
Adding Quirin to help with cross-checking.<br>
<br>
Thanks,<br>
Jan<br>
<br>
--<br>
Siemens AG, Foundational Technologies<br>
Linux Expert Center<br>
</div>
</body>
</html>

--_000_TYCPR01MB96693C40CB49321A6A982A32C499ATYCPR01MB9669jpnp_--


