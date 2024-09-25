Return-Path: <sai.sathujoda@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57322C369D6
	for <webhook@archiver.kernel.org>; Wed, 25 Sep 2024 12:11:17 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.134])
 by mx.groups.io with SMTP id smtpd.web11.14407.1727266269553652030
 for <cip-dev@lists.cip-project.org>;
 Wed, 25 Sep 2024 05:11:10 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.134, mailfrom: sai.sathujoda@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1800) id 48PCB7rP2486649; Wed, 25 Sep 2024 21:11:08 +0900
X-Iguazu-Qid: 2yAa7nzfb1jzKSzNR6
X-Iguazu-QSIG: v=2; s=0; t=1727266267; q=2yAa7nzfb1jzKSzNR6; m=bbbtM9p8kMqMXvwATTOa4teMmQV+Z6N944khZns0CUU=
Received: from imx12-a.toshiba.co.jp ([38.106.60.135])
	by relay.securemx.jp (mx-mr1801) id 48PCB6mQ2062689
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 25 Sep 2024 21:11:06 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dubCsG/RYtw89BMhoHIoeDlK27JkIoYdSwTaBZQXYBm/pPCfZoN2SYgZlquaKB5hhGuuQ2twIGrsf4h6Hm5eJluo5pXAs/FLiFhil8WORHDUAaNT2biaYacsQIHb2jlTWPSJKOQCsFWxlGJvQBnZWIr374bqWwppZsZ/UstkAQgcCCRglEuJBrayXNTW6B+VBP7C1qHpG8UDhRQVAqNrnqidMCMQB8di+1k9ZxODvNmt1Pp4864DtySKkJhNfLvmlpSRLZPRQ0pZR7iq5E4ZH+D2EPQ6SHElmdZoZaPxUqjh0MfBEkPl3Gb68+1D4DATbprNNY+ubVAF2jKQjhGwXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YMDR8qTyrUHb9w6k5o5HaRwHFXkEi8NBw9zUNxkQq44=;
 b=etF11VOBO79P4sYbmNR/8KeoNqfBr+pb6K09qLdTyyGEIw2umw2UoJuer1uVlJ9WHyFrBRKJn8lTLRVomQraatftzQ2EwyYkts+j/4i3RMStuv0lsek+/nt1OMmHReKC5Y0Jq83goYUeBuesP+M/rO4zlT+TGGG1bmusuludx7ADZOfFNCgfcz/C45xPFvXNY8ATWVytoDZPNSNo265Q8TonOHV/JmlgQPBhoDR5d2Ai1ydNIdpXBucD3aXU0tm6jJgxPkZaDHBtX0uz5uOdTu/rLOw46+xQH0EIxuNAcWMPnxAJloM7X9nfV0FFfLDQcEziOA8CLjwrUu2Q0YfcBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba-tsip.com; dmarc=pass action=none
 header.from=toshiba-tsip.com; dkim=pass header.d=toshiba-tsip.com; arc=none
From: <Sai.Sathujoda@toshiba-tsip.com>
To: <Chris.Paterson2@renesas.com>, <michael.adler@siemens.com>
CC: <kazuhiro3.hayashi@toshiba.co.jp>, <dinesh.kumar@toshiba-tsip.com>,
        <cip-dev@lists.cip-project.org>
Subject: Re: [cip-dev] Issue with 'small' Gitlab runners
Thread-Topic: [cip-dev] Issue with 'small' Gitlab runners
Thread-Index: 
 Adr6EQ3RL8rQAtQSSy+tF4/i30H+FAACvaEwAB6AvfAAoAnrAABqrZEQBBtW1XAAAKEVoQAAz0WwAAOVntU=
Date: Wed, 25 Sep 2024 12:11:03 +0000
X-TSB-HOP2: ON
Message-ID: 
 <OS3PR01MB6103F8BD30E6848284A4C0C4C2692@OS3PR01MB6103.jpnprd01.prod.outlook.com>
References: 
 <OS3PR01MB6103DA72FFDEBC407A5900A6C2962@OS3PR01MB6103.jpnprd01.prod.outlook.com>
 <TYYPR01MB12402CF459412685A6824CB45B7962@TYYPR01MB12402.jpnprd01.prod.outlook.com>
 <OS3PR01MB610349E8EFC2F9E8ECEBD450C2972@OS3PR01MB6103.jpnprd01.prod.outlook.com>
 <cnkp47rzuahu7yls5ch2mi6okr6w3uevw6eqehmc3ti3f6zesu@of6ittbitant>
 <OS3PR01MB61035250A83977730E393D70C29C2@OS3PR01MB6103.jpnprd01.prod.outlook.com>
 <OS9PR01MB12389D4A1AC2973E4C3AF27FDB7692@OS9PR01MB12389.jpnprd01.prod.outlook.com>
 <OS3PR01MB610365D7958F2829214B6BF1C2692@OS3PR01MB6103.jpnprd01.prod.outlook.com>
 <OS9PR01MB12389DB1E8371D5A1747C9094B7692@OS9PR01MB12389.jpnprd01.prod.outlook.com>
In-Reply-To: 
 <OS9PR01MB12389DB1E8371D5A1747C9094B7692@OS9PR01MB12389.jpnprd01.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba-tsip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS3PR01MB6103:EE_|TYYPR01MB12982:EE_
x-ms-office365-filtering-correlation-id: f5f384b6-b5f7-4b62-9109-08dcdd5b2053
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: 
 =?iso-2022-jp?B?U1YxeFhLcE9USENBZE05OTFWczBIZ2pQOVhBSExQRENWREYrN21oQ1lO?=
 =?iso-2022-jp?B?R0hFQjgxSk4zNmVhVWZJOGJTOW5BN3RJZnFLc0d6Nm5YVjNLZ0UxeE1l?=
 =?iso-2022-jp?B?Z0x3RnZvMEIvUzRlMXZIZzJaeEdockpxVitvSHpDTmtVUjRwUUtvL1Fy?=
 =?iso-2022-jp?B?UW9VTktRUTJDZ2M2Q2Fpb1VpYVV6MmRUb21Jdkt4cjlWa0ViNGlpSFJM?=
 =?iso-2022-jp?B?VEQ0ZFo1UlJ0aTY5WStDN0pESU5Dd2c5eUpTVTQvTkttczI0cnZJRkpZ?=
 =?iso-2022-jp?B?S1dvNzVWdkF6VFhOM0YvMjlmOXZET1EzM1V2QndlZnNIV281TkxxanFX?=
 =?iso-2022-jp?B?Y081bU5hY1ZZZ3E2VVZKM0N2QXRMaEkzRVJSV1ZLMzhiSjZucStSUmZz?=
 =?iso-2022-jp?B?MldDdUpBeHhUc3ZMMUlpbFUvNEJwTEllVkdreFU2MUIyMWMxY0lBb2hv?=
 =?iso-2022-jp?B?NzkvUUh1bWcvanRsalZqL2trWGJmTjJMeXBGUWljRkNTQzVnWGY0Mm9X?=
 =?iso-2022-jp?B?b3h5eEFvWkRtTFVZU011SHl1YkNORVJKVUkxQ3hjbElTemVVK1B2RlJk?=
 =?iso-2022-jp?B?alg0NmNDeWV5S2Fic3dTOGF2NURITitjbTE5K0tFUXdJZGpXeDhkWSs3?=
 =?iso-2022-jp?B?T0w5aWgyVWRsOE85M2R5aG9oY1l6NmtkYmNrMlhIeTg0KzhCeCtvZHlG?=
 =?iso-2022-jp?B?elk5N25yTHh1YmRCK0d6VCtyY3BhNHRQTWlseXhQVGEybzM4NVFXd1Fp?=
 =?iso-2022-jp?B?U1lmdGp1MW5nNXlEbDJaK0I2TzNta1RmMlZ3UE9EUUtaM3k5dk1aN2pJ?=
 =?iso-2022-jp?B?UHNBUE9hZFV6c2ZVUTdMaDFmdEtrbm1LL09pNXdJMnNzVS9Gb2Zhb3VX?=
 =?iso-2022-jp?B?aVEwQUhZWFlYSjk0bnNGb0RERVdSZ0RIQUkrVmVpVlpQM1FvT1lUYTVi?=
 =?iso-2022-jp?B?UVVRaDhramgxTThCclV1b2ZlKzJpQk1iNnVHUEhlZEZ1c1VtL1pNZ05B?=
 =?iso-2022-jp?B?UkE0N3NpN3hVdGJkSWd4TTFNQzBYaUtIck5iZlJkVjhpdEtVUWtXcUlT?=
 =?iso-2022-jp?B?VjE3VXV4NkU0QUlXbENQOWlNTDBOc3czZ1ZyNG11Ykx4ZkpEb0tTNitw?=
 =?iso-2022-jp?B?ZUo5a3BRWGEzM0NUdGZtT0x2Y3ZrWWVjQ3E0M0NzZmt5eEJqUWY4MWNk?=
 =?iso-2022-jp?B?SUdRQjlYV2RFRC9uTG1WRDZtRjF0YVFhZ3pXdHBTcTZFc2F0cUZyQVBt?=
 =?iso-2022-jp?B?K1MxNmFaSXZOWGl6YUx4Nm5lcmh6L3BVTnhWSTlxRmpuWWpMVlBOaDJo?=
 =?iso-2022-jp?B?cW42eG9LbTZmV2hoRWp2ZVB3YlB5S0FEWEt2YkxPTng0UExCc0oxM3J0?=
 =?iso-2022-jp?B?OWVQc3YvMVBydWllZHl2VmljbWxkaGZ6SnVkclc4ek5tRjNqRnNrTHE1?=
 =?iso-2022-jp?B?MnZzdGIrZnZUZFhqcHd6SitvODc5dHNCclVJRk5sOFBtRW9UZVlWa2ZW?=
 =?iso-2022-jp?B?bGtuQ3kycGdJTFd3V3JBN1p5dm5RVFhxRHBhR1ZleWMvQmpGQnRUaEl0?=
 =?iso-2022-jp?B?NkVTUnJwUDRLWTMxWC81bU1jaHVMQW1PcUhDdy9sVmJlcnhjaFEyOUZz?=
 =?iso-2022-jp?B?SThhejdra2hvQWFrcEM1WFBWNnluRXRTUXZwTVlCUWo2M0p0elFjRGMx?=
 =?iso-2022-jp?B?emhDWlNMdm5RYlBZZ3NzQUZNTGtXcG4xNmluSDNUbG5xUm1MaVpmSVFE?=
 =?iso-2022-jp?B?Qjk4UnhvTGxqOUZxVVI1ZWxXeHRaTmFoQlhZNUtYMU5sZTNJTHBNN2N2?=
 =?iso-2022-jp?B?ekQwb0tvZjMwRk10bDFCcEg3T3lvOW5LbHZaZkZkNGJHUEZHOUZ2QmU2?=
 =?iso-2022-jp?B?MzE4dmxBYTlZT2VNSmd4VnY3TUp3PQ==?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS3PR01MB6103.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?NDZHQUNTSzRuZE5Uei9TVUVjb0txWE9MdjNKNFZ4NHc3MTVFUWF0YlRE?=
 =?iso-2022-jp?B?cWExV1kzWlhnQk9yUWVrWkwwM0dVV2sxSjl1cDI4ZTZBbEpsdzFoemFS?=
 =?iso-2022-jp?B?OW5FcUVVZkpHblB5VEJmMHUwcDVwdldRVlJyRXJNQnNqcm9RVDNrMXpu?=
 =?iso-2022-jp?B?ODN0blBvMlBYbXpQQTdoMUJQNTFTZjRkUWJQL2lnaVJWUjgrSnBmQzlZ?=
 =?iso-2022-jp?B?RWhMNTR5TDB1WHhIb3ZYTlJQQytxeWxiTnE1SXZvVkN0c1ZadHRUR3Nk?=
 =?iso-2022-jp?B?M05pbExncm5Pd0k3SlNhZDd6UUsxWlBSTlc3bWRYVjFoa3BSRlVXKzBW?=
 =?iso-2022-jp?B?dVVtSkYxVDhIbkozcDlLMWY4UDIwZXUydmVvRzFaRWU5M2hnYnZ2U3Rx?=
 =?iso-2022-jp?B?L3FiamxsWDg5dzRacWxKaVBIZDNZWXNwdHFxRTlpMkp6ZDNmQjFSaGN5?=
 =?iso-2022-jp?B?M01iQlN0TFFRRTZCU3lmdXE4SE9MK1hkWms2TzdoT1lDejROaXVkeXI5?=
 =?iso-2022-jp?B?cHpEbTFIclFqeVkyR0gyK2ptK2Q3dTV1cm0xUXlNdlMrZkhOd1Z4bWdo?=
 =?iso-2022-jp?B?ZUNqNVUyVi9FdUsrZGEweVFyZHE3QnJWT0RCZTVLUGNuTnNYbkRvbmRD?=
 =?iso-2022-jp?B?RjhEdHQ3ak92YUJZb0dDTkdWRk9tbHp1Z3JGa0VNYTlrUTlYbHZ6akwr?=
 =?iso-2022-jp?B?RDh5Mnp5THlYR29MajcwOWNqNEhVNE9QZnVmMUF5UStwaEdQajVDVGhY?=
 =?iso-2022-jp?B?WWM2Rm8vb3cvY0pWK3lsUXZHK3RwTWVSZWs0NW42SVdFMzJRRC8yUjIz?=
 =?iso-2022-jp?B?VTFFQmFXUk1aVC9wQnhQZ3V5bVZoeWpsUzZ2NXowNTFaanBiZnV3bXJw?=
 =?iso-2022-jp?B?UlNmeGU2V2o1T1d4TlJ2MDhKT2hMbVRJWHliRkM0NnFFYVFUTFlQR2NN?=
 =?iso-2022-jp?B?OURPMnp3cmllditJOWpiYmdHMlNtcFJBeXlVenNzQTU3QUF5Tzdrd0M5?=
 =?iso-2022-jp?B?WmJWRDdOK2FiNlFBZ21Xa0FRdWwxZ2w5RVpFOGpaNlpEendzUHdSVFht?=
 =?iso-2022-jp?B?WTA1R2duaHdidlJDa2NzOWc1djA2YytxRi9Db1dTVW9pVXNUMVZ2OVR1?=
 =?iso-2022-jp?B?MXZ5Zi8vWTNLbjdWbzk1U1gvRjJZMjU2VjR0TFZmSE9MVC9CcXN0S09n?=
 =?iso-2022-jp?B?eHNFbGNqc1lPd29WVkZCOFVuWXhjK3IrK1I5OCtkNFNVU2ZWZE1DUlU5?=
 =?iso-2022-jp?B?MnpDc2ozVEt2ZnhVZ2dKdk9oSlIrWU8rRXYyWjlsaXZ6Nk05SHV0QlEv?=
 =?iso-2022-jp?B?VnVNVTgzYkxzMjV3Ym96YVYrbkNTTmc3c2Rwd1JFR3BYQVA5ZE5EZkkz?=
 =?iso-2022-jp?B?UkJqaDJaejgyOWN4VXBwOTdMTFRyL1JxY3A5YmVld1FnSUFLaGdiS05q?=
 =?iso-2022-jp?B?dm5nMFF0RjRGOVdSNjl5eXlxV3ZLaGt6SEFuYkRsWTlwWjJ5NXRRS05J?=
 =?iso-2022-jp?B?TTBDOVAzWUFkOXZxWmJqSUZtQXNXRUV6VDhHMEFVYU4rejI2bGg0NDFK?=
 =?iso-2022-jp?B?ejJ2S1F4eVdOMWE3YlBTbmxrZmdLdktxc3QxcWw5clFmTmZzbmc5d0c2?=
 =?iso-2022-jp?B?SnlvdHRXZW5XZnMzcE5oUVVHQ0NoTTZZUTM3dmNyS0hGODYrUVdpYUx1?=
 =?iso-2022-jp?B?WFJEZTVuVzJ4V3FNTFVuUWMwM3VnelAzYzlSN0xLcEhKdlFlOVdwUHFU?=
 =?iso-2022-jp?B?MGREZlBmdEF0VXhrZElSdXk0UEcyTGt0dlhreFVidE85V1p2djVLQWw5?=
 =?iso-2022-jp?B?RmRyenJmTzkxTmw2d3o3aWdZK1JTMDlvemtBQm85bnVLaVYxZlV1OXhP?=
 =?iso-2022-jp?B?M01rWTdtOW1oQ3IyNk5sUnJZRXA3OWhxcS9oL0NqNTBHd0hBbU15T0lR?=
 =?iso-2022-jp?B?Y1d4czAva1VjOFBjQWt5NFZBNEdZWFlGR3BKVkpPK2Vxc2hkQm5NZDg2?=
 =?iso-2022-jp?B?Q3JLRkJDRjJFb21XWmpxQ0FGUVR4TWZZQkJrM2c4aldWeVNZcFdYaFpR?=
 =?iso-2022-jp?B?UVB0VlZldFU4dVBxS0VQWXhEY1pUaGkrc1lVNlJGRVQrWkRHVDdrUnRt?=
 =?iso-2022-jp?B?aFc1bTRkd0tyMUxsbk9HUU5zWnRQTVh4OUxMZk1ucUFmTjVEajVnbkxE?=
 =?iso-2022-jp?B?cTZ6TGo5eXdvbkF1VVI3UHFoSkNrK1dSK1gxcHNGVHRlUEhnbmF4emVU?=
 =?iso-2022-jp?B?U3dDemF2eHZVUEd0a2RmMjhxR1czU0pCT25ES3lzcmxIVXNjTElKZ3hE?=
 =?iso-2022-jp?B?d2h3cU9QWHl6STZxbGR5Y1l3ZDJSU3hYMnc9PQ==?=
Content-Type: multipart/alternative;
	boundary="_000_OS3PR01MB6103F8BD30E6848284A4C0C4C2692OS3PR01MB6103jpnp_"
MIME-Version: 1.0
X-OriginatorOrg: toshiba-tsip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS3PR01MB6103.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f5f384b6-b5f7-4b62-9109-08dcdd5b2053
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Sep 2024 12:11:03.3639
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3AW2yJRbgBmC4e3RtaJsd/iA38pM+/iUGh/XWftookekmuqvf2azHnwZQnWs35cpbgoFHzCE9MuxQ5MfqduQKIWrejUEVUuReM6mXOX/3d8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYPR01MB12982
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 25 Sep 2024 12:11:17 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16917

--_000_OS3PR01MB6103F8BD30E6848284A4C0C4C2692OS3PR01MB6103jpnp_
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable

Hello Chris,

Currently I am not sure about the level of tasks which can be run in small =
runners. But based on our continuous tries done from last month, it seems g=
enerating cve reports for 18 targets is intensive for small runners.

Then it is better to use large runners for this job.

Regards,
Sai Ashrith Sathujoda
________________________________
From: Chris Paterson <Chris.Paterson2@renesas.com>
Sent: Wednesday, September 25, 2024 5:13 PM
To: ashrith sai(=1B$B#T#S#I#P=1B(B) <Sai.Sathujoda@toshiba-tsip.com>; micha=
el.adler@siemens.com <michael.adler@siemens.com>
Cc: hayashi kazuhiro(=1B$BNS=1B(B =1B$BOB9(=1B(B =1B$B#D#M#E=1B(B =1B$B!{#D=
#I#G""#M#P#S!{#M#P#4=1B(B) <kazuhiro3.hayashi@toshiba.co.jp>; dinesh kumar(=
=1B$B#T#S#I#P=1B(B TMIEC ODG Porting) <dinesh.kumar@toshiba-tsip.com>; cip-=
dev@lists.cip-project.org <cip-dev@lists.cip-project.org>
Subject: RE: [cip-dev] Issue with 'small' Gitlab runners


Hello Sai,



Do you know how long the cve checks normally take?

I=1B$B!G=1B(Bve set up my own branch for some debugging and the =1B$B!H=1B(=
BChecking hihope-rzg2m-buster.dpkg_status=1B$B!I=1B(B line seems to take an=
 extremely long time.

Either that or it=1B$B!G=1B(Bs done, and now it=1B$B!G=1B(Bs doing the aws =
s3 sync that=1B$B!G=1B(Bs done afterwards, and this is the step that is tak=
ing forever.



Indeed, looking at your job linked below, it took 49 minutes to the point w=
here it failed.



How long does it take to run the cve-check script locally?

Outside of the specific issue you=1B$B!G=1B(Bre seeing, if it=1B$B!G=1B(Bs =
very CPU intensive then perhaps we=1B$B!G=1B(Bre better to use the =1B$B!H=
=1B(Blarge=1B$B!I=1B(B runners?



Kind regards, Chris



From: Sai.Sathujoda@toshiba-tsip.com <Sai.Sathujoda@toshiba-tsip.com>
Sent: Wednesday, September 25, 2024 10:57 AM
To: Chris Paterson <Chris.Paterson2@renesas.com>; michael.adler@siemens.com
Cc: kazuhiro3.hayashi@toshiba.co.jp; dinesh.kumar@toshiba-tsip.com; cip-dev=
@lists.cip-project.org
Subject: Re: [cip-dev] Issue with 'small' Gitlab runners



Hello Chris,



This issue is still present in small runners. I ran the cve-checks job toda=
y. https://gitlab.com/cip-project/cip-core/isar-cip-core/-/jobs/7885795173#=
L655



It still shows 'Job failed (system failure): pods "runner-zwslwy9eu-project=
-10191315-concurrent-0-ulyylb1h" not found'.



Thanks and regards,

Sai Ashrith Sathujoda

________________________________

From: Chris Paterson <Chris.Paterson2@renesas.com<mailto:Chris.Paterson2@re=
nesas.com>>
Sent: Wednesday, September 25, 2024 3:06 PM
To: ashrith sai(=1B$B#T#S#I#P=1B(B) <Sai.Sathujoda@toshiba-tsip.com<mailto:=
Sai.Sathujoda@toshiba-tsip.com>>; michael.adler@siemens.com<mailto:michael.=
adler@siemens.com> <michael.adler@siemens.com<mailto:michael.adler@siemens.=
com>>
Cc: hayashi kazuhiro(=1B$BNS=1B(B =1B$BOB9(=1B(B =1B$B#D#M#E=1B(B =1B$B!{#D=
#I#G""#M#P#S!{#M#P#4=1B(B) <kazuhiro3.hayashi@toshiba.co.jp<mailto:kazuhiro=
3.hayashi@toshiba.co.jp>>; dinesh kumar(=1B$B#T#S#I#P=1B(B TMIEC ODG Portin=
g) <dinesh.kumar@toshiba-tsip.com<mailto:dinesh.kumar@toshiba-tsip.com>>
Subject: RE: [cip-dev] Issue with 'small' Gitlab runners



Hello Sai,

> From: Sai.Sathujoda@toshiba-tsip.com<mailto:Sai.Sathujoda@toshiba-tsip.co=
m> <Sai.Sathujoda@toshiba-tsip.com<mailto:Sai.Sathujoda@toshiba-tsip.com>>
> Sent: Wednesday, September 4, 2024 12:53 PM
>
> Hello Michael,
>
> I ran this job multiple times recently. I am seeing 'pods runner-
> zwslwy9eu-project-10191315-concurrent-0-2fdr4qlb not found issue' again
> while using small runner. https://gitlab.com/cip-project/cip-core/isar-
> cip-core/-/jobs/7740352129

Are you still seeing these issues?

Kind regards, Chris

>
> When I run with large runners, the job is successful ->
> https://gitlab.com/cip-project/cip-core/isar-cip-core/-/jobs/7742283984 .
> That is why I suspected there might be an issue with small runners. Can
> you please provide your opinion on this ?
>
> Regards,
> Sai Ashrith Sathujoda (T S I P)
>
> -----Original Message-----
> From: cip-dev@lists.cip-project.org<mailto:cip-dev@lists.cip-project.org>=
 <cip-dev@lists.cip-project.org<mailto:cip-dev@lists.cip-project.org>> On
> Behalf Of Michael Adler via lists.cip-project.org
> Sent: Monday, September 2, 2024 2:28 PM
> To: cip-dev@lists.cip-project.org<mailto:cip-dev@lists.cip-project.org>
> Cc: Chris.Paterson2@renesas.com<mailto:Chris.Paterson2@renesas.com>; haya=
shi kazuhiro(=1B$BNS=1B(B =1B$BOB9(=1B(B =1B$B#D#M#E=1B(B
> =1B$B!{#D#I#G""#M#P#S!{#M#P#4=1B(B) <kazuhiro3.hayashi@toshiba.co.jp<mail=
to:kazuhiro3.hayashi@toshiba.co.jp>>; dinesh
> kumar(=1B$B#T#S#I#P=1B(B TMIEC ODG Porting) <dinesh.kumar@toshiba-tsip.co=
m<mailto:dinesh.kumar@toshiba-tsip.com>>
> Subject: Re: [cip-dev] Issue with 'small' Gitlab runners
>
> Hi Sai,
>
> > I thought there might be some issue with the runners as the job failure
> message said, =1B$B!H=1B(BThere has been a runner system failure, please =
try again.=1B$B!I=1B(B
>
> maybe there was a temporary issue. I just looked at the cluster and it
> seems to be (idling) fine. So I'd suggest to try it again.
>
> Kind Regards,
>   Michael
>
> --
> Michael Adler
>
> Siemens AG
> Technology
> Connectivity & Edge
> Open Source Embedded Systems
> T CED OES-DE
> Friedrich-Ludwig-Bauer-Str. 3
> 85748 Garching, Germany
>
> Siemens Aktiengesellschaft: Chairman of the Supervisory Board: Jim
> Hagemann Snabe; Managing Board: Roland Busch, Chairman, President and
> Chief Executive Officer; Cedrik Neike, Matthias Rebellius, Ralf P. Thomas=
,
> Judith Wiese; Registered offices: Berlin and Munich, Germany; Commercial
> registries:
> Berlin-Charlottenburg, HRB 12300, Munich, HRB 6684; WEEE-Reg.-No. DE
> 23691322

--_000_OS3PR01MB6103F8BD30E6848284A4C0C4C2692OS3PR01MB6103jpnp_
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
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
Hello Chris,</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
Currently I am not sure about the level of tasks which can be run in small =
runners. But based on our continuous tries done from last month, it seems g=
enerating cve reports for 18 targets is intensive for small runners.</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
Then it is better to use large runners for this job.</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
Regards,</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
Sai Ashrith Sathujoda</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Chris Paterson &lt;Ch=
ris.Paterson2@renesas.com&gt;<br>
<b>Sent:</b> Wednesday, September 25, 2024 5:13 PM<br>
<b>To:</b> ashrith sai(=1B$B#T#S#I#P=1B(B) &lt;Sai.Sathujoda@toshiba-tsip.c=
om&gt;; michael.adler@siemens.com &lt;michael.adler@siemens.com&gt;<br>
<b>Cc:</b> hayashi kazuhiro(=1B$BNS=1B(B =1B$BOB9(=1B(B =1B$B#D#M#E=1B(B =
=1B$B!{#D#I#G""#M#P#S!{#M#P#4=1B(B) &lt;kazuhiro3.hayashi@toshiba.co.jp&gt;=
; dinesh kumar(=1B$B#T#S#I#P=1B(B TMIEC ODG Porting) &lt;dinesh.kumar@toshi=
ba-tsip.com&gt;; cip-dev@lists.cip-project.org &lt;cip-dev@lists.cip-projec=
t.org&gt;<br>
<b>Subject:</b> RE: [cip-dev] Issue with 'small' Gitlab runners</font>
<div>&nbsp;</div>
</div>
<style>
<!--
@font-face
	{font-family:"Cambria Math"}
@font-face
	{font-family:Calibri}
@font-face
	{font-family:Aptos}
@font-face
	{font-family:"MS PGothic"}
p.x_MsoNormal, li.x_MsoNormal, div.x_MsoNormal
	{margin:0cm;
	font-size:12.0pt;
	font-family:"MS PGothic",sans-serif}
a:link, span.x_MsoHyperlink
	{color:blue;
	text-decoration:underline}
span.x_EmailStyle20
	{font-family:"Calibri",sans-serif;
	color:#7030A0;
	font-weight:normal;
	font-style:normal;
	text-decoration:none none}
.x_MsoChpDefault
	{font-size:10.0pt}
@page WordSection1
	{margin:72.0pt 72.0pt 72.0pt 72.0pt}
div.x_WordSection1
	{}
-->
</style>
<div lang=3D"EN-GB" link=3D"blue" vlink=3D"purple" style=3D"word-wrap:break=
-word">
<div class=3D"x_WordSection1">
<p class=3D"x_MsoNormal"><span style=3D"font-size:11.0pt; font-family:&quot=
;Calibri&quot;,sans-serif; color:#7030A0">Hello Sai,</span></p>
<p class=3D"x_MsoNormal"><span style=3D"font-size:11.0pt; font-family:&quot=
;Calibri&quot;,sans-serif; color:#7030A0">&nbsp;</span></p>
<p class=3D"x_MsoNormal"><span style=3D"font-size:11.0pt; font-family:&quot=
;Calibri&quot;,sans-serif; color:#7030A0">Do you know how long the cve chec=
ks normally take?</span></p>
<p class=3D"x_MsoNormal"><span style=3D"font-size:11.0pt; font-family:&quot=
;Calibri&quot;,sans-serif; color:#7030A0">I=1B$B!G=1B(Bve set up my own bra=
nch for some debugging and the =1B$B!H=1B(BChecking hihope-rzg2m-buster.dpk=
g_status=1B$B!I=1B(B line seems to take an extremely long time.</span></p>
<p class=3D"x_MsoNormal"><span style=3D"font-size:11.0pt; font-family:&quot=
;Calibri&quot;,sans-serif; color:#7030A0">Either that or it=1B$B!G=1B(Bs do=
ne, and now it=1B$B!G=1B(Bs doing the aws s3 sync that=1B$B!G=1B(Bs done af=
terwards, and this is the step that is taking forever.</span></p>
<p class=3D"x_MsoNormal"><span style=3D"font-size:11.0pt; font-family:&quot=
;Calibri&quot;,sans-serif; color:#7030A0">&nbsp;</span></p>
<p class=3D"x_MsoNormal"><span style=3D"font-size:11.0pt; font-family:&quot=
;Calibri&quot;,sans-serif; color:#7030A0">Indeed, looking at your job linke=
d below, it took 49 minutes to the point where it failed.</span></p>
<p class=3D"x_MsoNormal"><span style=3D"font-size:11.0pt; font-family:&quot=
;Calibri&quot;,sans-serif; color:#7030A0">&nbsp;</span></p>
<p class=3D"x_MsoNormal"><span style=3D"font-size:11.0pt; font-family:&quot=
;Calibri&quot;,sans-serif; color:#7030A0">How long does it take to run the =
cve-check script locally?</span></p>
<p class=3D"x_MsoNormal"><span style=3D"font-size:11.0pt; font-family:&quot=
;Calibri&quot;,sans-serif; color:#7030A0">Outside of the specific issue you=
=1B$B!G=1B(Bre seeing, if it=1B$B!G=1B(Bs very CPU intensive then perhaps w=
e=1B$B!G=1B(Bre better to use the =1B$B!H=1B(Blarge=1B$B!I=1B(B runners?</s=
pan></p>
<p class=3D"x_MsoNormal"><span style=3D"font-size:11.0pt; font-family:&quot=
;Calibri&quot;,sans-serif; color:#7030A0">&nbsp;</span></p>
<div>
<p class=3D"x_MsoNormal"><span style=3D"font-size:11.0pt; font-family:&quot=
;Aptos&quot;,sans-serif; color:#7030A0">Kind regards, Chris</span></p>
</div>
<p class=3D"x_MsoNormal"><span style=3D"font-size:11.0pt; font-family:&quot=
;Calibri&quot;,sans-serif; color:#7030A0">&nbsp;</span></p>
<div style=3D"border:none; border-left:solid blue 1.5pt; padding:0cm 0cm 0c=
m 4.0pt">
<div>
<div style=3D"border:none; border-top:solid #E1E1E1 1.0pt; padding:3.0pt 0c=
m 0cm 0cm">
<p class=3D"x_MsoNormal"><b><span lang=3D"EN-US" style=3D"font-size:11.0pt;=
 font-family:&quot;Calibri&quot;,sans-serif">From:</span></b><span lang=3D"=
EN-US" style=3D"font-size:11.0pt; font-family:&quot;Calibri&quot;,sans-seri=
f"> Sai.Sathujoda@toshiba-tsip.com &lt;Sai.Sathujoda@toshiba-tsip.com&gt;
<br>
<b>Sent:</b> Wednesday, September 25, 2024 10:57 AM<br>
<b>To:</b> Chris Paterson &lt;Chris.Paterson2@renesas.com&gt;; michael.adle=
r@siemens.com<br>
<b>Cc:</b> kazuhiro3.hayashi@toshiba.co.jp; dinesh.kumar@toshiba-tsip.com; =
cip-dev@lists.cip-project.org<br>
<b>Subject:</b> Re: [cip-dev] Issue with 'small' Gitlab runners</span></p>
</div>
</div>
<p class=3D"x_MsoNormal">&nbsp;</p>
<div>
<p class=3D"x_MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-=
serif; color:black">Hello Chris,</span></p>
</div>
<div>
<p class=3D"x_MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-=
serif; color:black">&nbsp;</span></p>
</div>
<div>
<p class=3D"x_MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-=
serif; color:black">This issue is still present in small runners. I ran the=
 cve-checks job today.
<a href=3D"https://gitlab.com/cip-project/cip-core/isar-cip-core/-/jobs/788=
5795173#L655">
https://gitlab.com/cip-project/cip-core/isar-cip-core/-/jobs/7885795173#L65=
5</a></span></p>
</div>
<div>
<p class=3D"x_MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-=
serif; color:black">&nbsp;</span></p>
</div>
<div>
<p class=3D"x_MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-=
serif; color:black">It still shows '<b>Job failed (system failure): pods &q=
uot;runner-zwslwy9eu-project-10191315-concurrent-0-ulyylb1h&quot; not found=
'.</b></span></p>
</div>
<div>
<p class=3D"x_MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-=
serif; color:black">&nbsp;</span></p>
</div>
<div>
<p class=3D"x_MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-=
serif; color:black">Thanks and regards,</span></p>
</div>
<div>
<p class=3D"x_MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-=
serif; color:black">Sai Ashrith Sathujoda</span></p>
</div>
<div class=3D"x_MsoNormal" align=3D"center" style=3D"text-align:center">
<hr size=3D"2" width=3D"98%" align=3D"center">
</div>
<div id=3D"x_divRplyFwdMsg">
<p class=3D"x_MsoNormal"><b><span style=3D"font-size:11.0pt; font-family:&q=
uot;Calibri&quot;,sans-serif; color:black">From:</span></b><span style=3D"f=
ont-size:11.0pt; font-family:&quot;Calibri&quot;,sans-serif; color:black"> =
Chris Paterson &lt;<a href=3D"mailto:Chris.Paterson2@renesas.com">Chris.Pat=
erson2@renesas.com</a>&gt;<br>
<b>Sent:</b> Wednesday, September 25, 2024 3:06 PM<br>
<b>To:</b> ashrith sai(</span><span lang=3D"JA" style=3D"font-size:11.0pt; =
color:black">=1B$B#T#S#I#P=1B(B</span><span style=3D"font-size:11.0pt; font=
-family:&quot;Calibri&quot;,sans-serif; color:black">) &lt;<a href=3D"mailt=
o:Sai.Sathujoda@toshiba-tsip.com">Sai.Sathujoda@toshiba-tsip.com</a>&gt;;
<a href=3D"mailto:michael.adler@siemens.com">michael.adler@siemens.com</a> =
&lt;<a href=3D"mailto:michael.adler@siemens.com">michael.adler@siemens.com<=
/a>&gt;<br>
<b>Cc:</b> hayashi kazuhiro(</span><span lang=3D"JA" style=3D"font-size:11.=
0pt; color:black">=1B$BNS=1B(B</span><span lang=3D"JA" style=3D"font-size:1=
1.0pt; font-family:&quot;Calibri&quot;,sans-serif; color:black">
</span><span lang=3D"JA" style=3D"font-size:11.0pt; color:black">=1B$BOB9(=
=1B(B</span><span lang=3D"JA" style=3D"font-size:11.0pt; font-family:&quot;=
Calibri&quot;,sans-serif; color:black">
</span><span lang=3D"JA" style=3D"font-size:11.0pt; color:black">=1B$B#D#M#=
E=1B(B</span><span style=3D"font-size:11.0pt; font-family:&quot;Calibri&quo=
t;,sans-serif; color:black"> =1B$B!{=1B(B</span><span lang=3D"JA" style=3D"=
font-size:11.0pt; color:black">=1B$B#D#I#G=1B(B</span><span style=3D"font-s=
ize:11.0pt; font-family:&quot;Calibri&quot;,sans-serif; color:black">=1B$B"=
"=1B(B</span><span lang=3D"JA" style=3D"font-size:11.0pt; color:black">=1B$=
B#M#P#S=1B(B</span><span style=3D"font-size:11.0pt; font-family:&quot;Calib=
ri&quot;,sans-serif; color:black">=1B$B!{=1B(B</span><span lang=3D"JA" styl=
e=3D"font-size:11.0pt; color:black">=1B$B#M#P#4=1B(B</span><span style=3D"f=
ont-size:11.0pt; font-family:&quot;Calibri&quot;,sans-serif; color:black">)
 &lt;<a href=3D"mailto:kazuhiro3.hayashi@toshiba.co.jp">kazuhiro3.hayashi@t=
oshiba.co.jp</a>&gt;; dinesh kumar(</span><span lang=3D"JA" style=3D"font-s=
ize:11.0pt; color:black">=1B$B#T#S#I#P=1B(B</span><span style=3D"font-size:=
11.0pt; font-family:&quot;Calibri&quot;,sans-serif; color:black"> TMIEC
 ODG Porting) &lt;<a href=3D"mailto:dinesh.kumar@toshiba-tsip.com">dinesh.k=
umar@toshiba-tsip.com</a>&gt;<br>
<b>Subject:</b> RE: [cip-dev] Issue with 'small' Gitlab runners</span> </p>
<div>
<p class=3D"x_MsoNormal">&nbsp;</p>
</div>
</div>
<div>
<div>
<p class=3D"x_MsoNormal"><span style=3D"font-size:11.0pt">Hello Sai,<br>
<br>
&gt; From: <a href=3D"mailto:Sai.Sathujoda@toshiba-tsip.com">Sai.Sathujoda@=
toshiba-tsip.com</a> &lt;<a href=3D"mailto:Sai.Sathujoda@toshiba-tsip.com">=
Sai.Sathujoda@toshiba-tsip.com</a>&gt;<br>
&gt; Sent: Wednesday, September 4, 2024 12:53 PM<br>
&gt; <br>
&gt; Hello Michael,<br>
&gt; <br>
&gt; I ran this job multiple times recently. I am seeing 'pods runner-<br>
&gt; zwslwy9eu-project-10191315-concurrent-0-2fdr4qlb not found issue' agai=
n<br>
&gt; while using small runner. <a href=3D"https://gitlab.com/cip-project/ci=
p-core/isar-">
https://gitlab.com/cip-project/cip-core/isar-</a><br>
&gt; cip-core/-/jobs/7740352129<br>
<br>
Are you still seeing these issues?<br>
<br>
Kind regards, Chris<br>
<br>
&gt; <br>
&gt; When I run with large runners, the job is successful -&gt;<br>
&gt; <a href=3D"https://gitlab.com/cip-project/cip-core/isar-cip-core/-/job=
s/7742283984">
https://gitlab.com/cip-project/cip-core/isar-cip-core/-/jobs/7742283984</a>=
 .<br>
&gt; That is why I suspected there might be an issue with small runners. Ca=
n<br>
&gt; you please provide your opinion on this ?<br>
&gt; <br>
&gt; Regards,<br>
&gt; Sai Ashrith Sathujoda (T S I P)<br>
&gt; <br>
&gt; -----Original Message-----<br>
&gt; From: <a href=3D"mailto:cip-dev@lists.cip-project.org">cip-dev@lists.c=
ip-project.org</a> &lt;<a href=3D"mailto:cip-dev@lists.cip-project.org">cip=
-dev@lists.cip-project.org</a>&gt; On<br>
&gt; Behalf Of Michael Adler via lists.cip-project.org<br>
&gt; Sent: Monday, September 2, 2024 2:28 PM<br>
&gt; To: <a href=3D"mailto:cip-dev@lists.cip-project.org">cip-dev@lists.cip=
-project.org</a><br>
&gt; Cc: <a href=3D"mailto:Chris.Paterson2@renesas.com">Chris.Paterson2@ren=
esas.com</a>; hayashi kazuhiro(<span lang=3D"JA">=1B$BNS=1B(B =1B$BOB9(=1B(=
B =1B$B#D#M#E=1B(B</span><br>
&gt; =1B$B!{=1B(B<span lang=3D"JA">=1B$B#D#I#G=1B(B</span>=1B$B""=1B(B<span=
 lang=3D"JA">=1B$B#M#P#S=1B(B</span>=1B$B!{=1B(B<span lang=3D"JA">=1B$B#M#P=
#4=1B(B</span>) &lt;<a href=3D"mailto:kazuhiro3.hayashi@toshiba.co.jp">kazu=
hiro3.hayashi@toshiba.co.jp</a>&gt;; dinesh<br>
&gt; kumar(<span lang=3D"JA">=1B$B#T#S#I#P=1B(B</span> TMIEC ODG Porting) &=
lt;<a href=3D"mailto:dinesh.kumar@toshiba-tsip.com">dinesh.kumar@toshiba-ts=
ip.com</a>&gt;<br>
&gt; Subject: Re: [cip-dev] Issue with 'small' Gitlab runners<br>
&gt; <br>
&gt; Hi Sai,<br>
&gt; <br>
&gt; &gt; I thought there might be some issue with the runners as the job f=
ailure<br>
&gt; message said, =1B$B!H=1B(BThere has been a runner system failure, plea=
se try again.=1B$B!I=1B(B<br>
&gt; <br>
&gt; maybe there was a temporary issue. I just looked at the cluster and it=
<br>
&gt; seems to be (idling) fine. So I'd suggest to try it again.<br>
&gt; <br>
&gt; Kind Regards,<br>
&gt;&nbsp;&nbsp; Michael<br>
&gt; <br>
&gt; --<br>
&gt; Michael Adler<br>
&gt; <br>
&gt; Siemens AG<br>
&gt; Technology<br>
&gt; Connectivity &amp; Edge<br>
&gt; Open Source Embedded Systems<br>
&gt; T CED OES-DE<br>
&gt; Friedrich-Ludwig-Bauer-Str. 3<br>
&gt; 85748 Garching, Germany<br>
&gt; <br>
&gt; Siemens Aktiengesellschaft: Chairman of the Supervisory Board: Jim<br>
&gt; Hagemann Snabe; Managing Board: Roland Busch, Chairman, President and<=
br>
&gt; Chief Executive Officer; Cedrik Neike, Matthias Rebellius, Ralf P. Tho=
mas,<br>
&gt; Judith Wiese; Registered offices: Berlin and Munich, Germany; Commerci=
al<br>
&gt; registries:<br>
&gt; Berlin-Charlottenburg, HRB 12300, Munich, HRB 6684; WEEE-Reg.-No. DE<b=
r>
&gt; 23691322</span></p>
</div>
</div>
</div>
</div>
</div>
</body>
</html>

--_000_OS3PR01MB6103F8BD30E6848284A4C0C4C2692OS3PR01MB6103jpnp_--


