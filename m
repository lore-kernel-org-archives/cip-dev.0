Return-Path: <adithya.balakumar@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDB43C021B3
	for <webhook@archiver.kernel.org>; Mon, 24 Feb 2025 06:28:04 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.132])
 by mx.groups.io with SMTP id smtpd.web10.83169.1740378477075269711
 for <cip-dev@lists.cip-project.org>;
 Sun, 23 Feb 2025 22:27:57 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.132, mailfrom: adithya.balakumar@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1121) id 51O6RsZi1977845; Mon, 24 Feb 2025 15:27:54 +0900
X-Iguazu-Qid: 2rWhiV7hR6NTdgJeMa
X-Iguazu-QSIG: v=2; s=0; t=1740378474; q=2rWhiV7hR6NTdgJeMa; m=NPTa4jCexP+9v2zayrsTXU+UUrQqCi7Ber553B56ubo=
Received: from imx12-a.toshiba.co.jp ([38.106.60.135])
	by relay.securemx.jp (mx-mr1123) id 51O6Rqqt2372755
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 24 Feb 2025 15:27:53 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j5nNT7lTMmEj0BZpqCweRL84y2V7kkPP3+u8iF3OZHUD+dgtPsnEc7NKkvGPciKu5nBuPR5RH1xQRCCuNAt2fhazo/wRHqwIH+w7AZF/nk0ZRwvLma7FW/BJ64S34NW8iewhH0RTQocKWc+WsRaDK7NJlf16Uq6dyy3QMr80Du5lRme5BOpUt6mixGdbsYxjpZtMKGGw8kZQRncDmApAgQ7BfeJG9VspgIJ8VqOcX+r4JWXytOFkZG3wIwFtYgk/dHbT3KdhOl4r2Vq0jqr+2qvKtPVJl18rS3nk28akgdV5LgZ97RVs+PeTT0XzXD7zqOmzrFTlD46FOK7cPIY/gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BEM5zBifOeNIlTsnk6fTMzttS9D3WYI7yPqNSZBWIF0=;
 b=WPc7JS9ScNHFsELpAOURn8VTuX4s7LECFWfNWcqsMY0HpAb+GJ/3vprx5vSDhxl8sDYqWo8ik0mfrH7c2kdd/2Z9AzNcNx/qngtHcTsFR43bpKAq5XVc8Ht8vx1EjRfhTK6SxB5sn9+i200iqtDp7IT7zam/F8SaBAZ5Ge4k5UJwdOGl6JH94SudmSL1bp031iYHldZzd5qaLxh7a/b6T1MO4mhPBzteAzI1odowhIZGSC6RySOJWWJFBZtA6SgwL4MKOsb1nNfBM7QGNBCw1rh3oSs5xm5Er/smJ0Ujxbh38dHJALoQjuj/1h6XJ/1zg5I49wGt9c+S56wwHFfqfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba-tsip.com; dmarc=pass action=none
 header.from=toshiba-tsip.com; dkim=pass header.d=toshiba-tsip.com; arc=none
From: <Adithya.Balakumar@toshiba-tsip.com>
To: <cip-dev@lists.cip-project.org>
CC: <Shivanand.Kunijadar@toshiba-tsip.com>, <Sai.Sathujoda@toshiba-tsip.com>,
        <dinesh.kumar@toshiba-tsip.com>, <kazuhiro3.hayashi@toshiba.co.jp>,
        <felix.moessbauer@siemens.com>
Subject: Re: [cip-dev] [isar-cip-core][PATCH v1] wic: Set partition UUID for
 reproducibility
Thread-Topic: [cip-dev] [isar-cip-core][PATCH v1] wic: Set partition UUID for
 reproducibility
Thread-Index: AQHbhnYERhx5/rATpUyCgAuhKM7dmbNV+RCAgAADAMo=
Date: Mon, 24 Feb 2025 06:27:50 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TYCPR01MB9669FCE29DECB3DC2B0880DAC4C02@TYCPR01MB9669.jpnprd01.prod.outlook.com>
References: <20250224044549.2233331-1-Adithya.Balakumar@toshiba-tsip.com>
 <3a73fd27-09a2-4cf2-b4bb-3897807de76d@siemens.com>
In-Reply-To: <3a73fd27-09a2-4cf2-b4bb-3897807de76d@siemens.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba-tsip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYCPR01MB9669:EE_|OS3PR01MB8089:EE_
x-ms-office365-filtering-correlation-id: 528261ae-4993-44f9-e880-08dd549c5c96
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|366016|1800799024|376014|38070700018|7053199007;
x-microsoft-antispam-message-info: 
 =?iso-2022-jp?B?VTErckQrVWxCTmcrNVVndEJTY0tyWm5oNUdaVjhEczB1V2Ewd2o0TGpS?=
 =?iso-2022-jp?B?UGpkTkpmU2VmQmtVdVV3MDFXTnFOSldTRmc2WEV6MkZJaVZoak5Uc2J5?=
 =?iso-2022-jp?B?R1M3Z2hHa2N3TmFscVp3VlhrdVFZNFZVSkRNRGlYOWltWGtsV25JMXk3?=
 =?iso-2022-jp?B?bDlzMWg2Z3EvcWc1OUNjOFdQcWtyS1ZzTHo4NFN5S1BLcmVXQW9UN2VV?=
 =?iso-2022-jp?B?bVZBY2VEM3NDMkl5RTVSTGdpWFg4NHdnS0M1enN2NTVUVTVhb0RHcjRX?=
 =?iso-2022-jp?B?OWRiMGo2Smc0eDVOUTNUV0RrZjJNT0VCVDIyV0wxWkNYMVg0R3pqVUV1?=
 =?iso-2022-jp?B?aHR0dnQrZnpsOStTbDdNVUo2VGRhT1hRZmJEWU5EcGJScjRodGpNcGdX?=
 =?iso-2022-jp?B?aTFMTk5hZEo2WVc2VWlKc2pJTkhvVlpZQjBqK094SzdySis0ZXhXTGZF?=
 =?iso-2022-jp?B?NWZxWXBrTm9pMU0wUVdacEFuV0lwUlFsRDRsVStUc3RJeHlBZFIzZ0hl?=
 =?iso-2022-jp?B?R295a25FdlVrV3dvSTEyNTk5UlBSM3QrbTFOOUlYZUowUXJWcG5sb3Qv?=
 =?iso-2022-jp?B?ZEhBMzJ5YkZQUDhQSG5LNUw5U3BJWkQ2NFgvcDRkVmpPM01BenNWbkZi?=
 =?iso-2022-jp?B?a2hTcTJReXovZWsyNEY2YmRzdWxZeFlpd3BMbDdBSkwvTjJyaFFWTXU0?=
 =?iso-2022-jp?B?U2lFT0RrVDlJZFgrV1lna2RnZ2hoQ3RVRzRwZEVXaVAwaVQ2TG9GQ2tz?=
 =?iso-2022-jp?B?dEFreXIzdFR0a3ZwVjJLMkVydGdCdmtTaHJ3M1pYU2dNQmQ4Zk1qekpU?=
 =?iso-2022-jp?B?QlVGdkhIV3ZzL29YVEhZalpJNENFSHZhUHhTUzdjeE5LM3BvK2FLYU9r?=
 =?iso-2022-jp?B?ME1UeHVlVHFCbkhjekx3VEVTa0JrZHlGRVhlT0p0anArWGVIaStjdXdo?=
 =?iso-2022-jp?B?cTh1QnQvV1haV040WitralpsR2FxRlRxSEViTUREeml0dVgyTkZkWEU4?=
 =?iso-2022-jp?B?RGNVTDErSXVoUHhJTzYwcEh5RE9zNEIxWS94SW5DdmRhc1hVM2Njbzh3?=
 =?iso-2022-jp?B?Vm9UeTBpdmZ6SnNxMWhIMUlCclRxeHRJeXhkdldULzBsWmM1WHN2WitM?=
 =?iso-2022-jp?B?cHpCdUxKSlJOOFBKdEJPKy9XdytnZnB4MjlSMVdmMUdMOEpCMWFibk03?=
 =?iso-2022-jp?B?ZCszbG9aemJsYXdPRUpjK1NjbFFkcVorbUxlN2hud3VKeW9OeTRyU29z?=
 =?iso-2022-jp?B?WVEveUp2a3I0M0F6UmRJekNlSnlyVDdJVlB0Rk5IOWc4OXlwdTljUkF4?=
 =?iso-2022-jp?B?dm03cFZ0MXlVM0JvYVVwNG0yeERrdXliSS91QzNWVVdtZTRWaVhpeXZw?=
 =?iso-2022-jp?B?YldLWXNSSXIzaXE4elkyeGd4VWUxSFpvaklpUTVNQzdwWGJ0ZHh4KzUw?=
 =?iso-2022-jp?B?b25NWTNOZ1RzQTBmditCQW52NWJDcnZLTUUyZTU0UXR1R1pudFpqUUFY?=
 =?iso-2022-jp?B?ZWdtcjhQSU9VWTV6czQ3WEZpeGlPaFBTRFJZTDI1Y1BTc1VhczgycTdj?=
 =?iso-2022-jp?B?dmJpWnM0ZHdZbFVSTG1oSk1IWFN2UVg1RmduYWhtTlA5Q1QvenQ0SXho?=
 =?iso-2022-jp?B?dloxREtYRTFsUUV4RmJPU013aUhka3JxRzFzVkJoak5QU1EwZjZrU1R0?=
 =?iso-2022-jp?B?TFBFUmNqZURxellPVjNMV3pqOWRUZTVXNHBtdUlRa25kVnplRVgzM2ZN?=
 =?iso-2022-jp?B?M3Vob3lheVpDYW1ybkFvMnJWUHEyVGFDUzg0dHFRTDBUVlJ5RllaZFRI?=
 =?iso-2022-jp?B?SHA4ZU11aURDdVdTS2t1TGJYQ0ZxNUczbTVURlZTUUsvZDJEaEVMdFRm?=
 =?iso-2022-jp?B?N1FEcjNaTERnWUZiRnF3VjF5WmMxWnhwMEZCK2ptbks5d0R0S1h2THMz?=
 =?iso-2022-jp?B?OExUbGxQcmIxZmk5UWRiQ3Yzc20zZ2JpNDQ2R3UrRVg0amRjdmFrajJa?=
 =?iso-2022-jp?B?SXN6K1Bhb0M5bDBjdkgyb29wM2dscDFqenVkL25mTDdrL1k0b2kyWWRE?=
 =?iso-2022-jp?B?cHFyRThPc3M2eFRnTW96WlZYTzhUdld0T2o4blE2Yi8zZDk0dHhhaHBz?=
 =?iso-2022-jp?B?ZTJ3OHcrRm90TzJndURkVW81VlFGSkxnPT0=?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB9669.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018)(7053199007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?dHB4eXYydjhrWnhLeHZsdDdsTmF6YVkrR3NUTXpFaFN1Rk0zTFYwL1VE?=
 =?iso-2022-jp?B?SXNtbDNaTlJiVlphUHd2RmpqbTdNZyszRWRmQzFNalZCTThBbFI4U1Fa?=
 =?iso-2022-jp?B?ajc2SDU4aENYKzVIL3NJdTg5TWNEbFp6Wm5tZ1c1MkxCbDBOWDE3Qk1L?=
 =?iso-2022-jp?B?eWJTT2o2L2xhK2lRK0hnaVg0amNTVWNyVkRDdlcvZUhlV05vYzVGUTN0?=
 =?iso-2022-jp?B?MmN5ei9nM1FFcHZkNnZoNXhLaFVpWGg4ek5PQkR5VHl3VDNDMlFmZVBq?=
 =?iso-2022-jp?B?OE1laVN4K0ZpY0pXVFF0NjR5NytEMldOKzQrOXFGVlRYSElzQXc4UDRM?=
 =?iso-2022-jp?B?VzNNUTNSQVFjT3NLc1pwRGwxTGMvWVQxdjJoN1pvUyt0eVBuK2Q1UmQx?=
 =?iso-2022-jp?B?ZW1GZ2VxRmE4bXFKcU1rRFhOd3pPSmZxcDNqWkxCR095bVpDcld3YWpj?=
 =?iso-2022-jp?B?QjFuVjJEWllwVEppcnJzSzJhQ0k5RUR6V2d0K0hsNWdXenNtUENIcWE1?=
 =?iso-2022-jp?B?VWZFclFmVXFua0xKSkFKVEVIN2EwWTNvbk1rblovelVkYjl2SmxPWVNt?=
 =?iso-2022-jp?B?RmY0eXdMMFc0UG42c2pFcmFKVDJKRzI0UnVwUEIyY3BpUXpKWUJiTTN4?=
 =?iso-2022-jp?B?QnhoUXhJRDI2RG4rdVRoYTFMUkZLNVl6c1ZDQVh3TGRrMUkraXhaVHRj?=
 =?iso-2022-jp?B?MDZvelQzYUloOEpiNnFXTFRzTHRNWXNDVWxicWE0V1BobHJjMWc3eklk?=
 =?iso-2022-jp?B?RXR0YUYvZHNCMXZTK1p1NmR2OVp3bkh3NktSWjdSY2hvTG5DRVRQa1dL?=
 =?iso-2022-jp?B?b040bStid0U1RUhhTXhOSEJlK1JmaUhrejNiaDFnN1JMYmdVeGdwQlRW?=
 =?iso-2022-jp?B?SE5iUkIrRnhYS25URkk2ZWdPRm9MelJWVkhYVTRLcDN5OTQyMlI2bmgz?=
 =?iso-2022-jp?B?WXVWNURMZlZaaDBYMnpKWHppeFdGNHc4dnQ1UERHK3Zsbzh2cU1VY3Ri?=
 =?iso-2022-jp?B?citMUTN1aXpLUms4UTltbXV6TE1lSHFnMTgzeEFQK09kczRqVjBhemN4?=
 =?iso-2022-jp?B?dUdQanRqYXBicEFqdS9sQmg1akhFYm12Q0dFRWhyaHpVd2IvYUtkT2Zs?=
 =?iso-2022-jp?B?ck9QZlNreklGODg4aE5sUFFWcWc0MXRhWTE0NlQzNFdlT1kwUXNuM1hV?=
 =?iso-2022-jp?B?ZGNSbnVWdTFhcnhVaHFYL2l2dmYxNDR1Tmh3Vnd0VitUZ2lkS1Y1NDhn?=
 =?iso-2022-jp?B?Yi8yc2dlR2h4bm5abEpGUlk2bmZ3VElsdHN5a000YnA1R3BsSGZjMlBR?=
 =?iso-2022-jp?B?UEVXeGNuOG95UGI1MzJFdEVFMzFENGdXZm9veVQra24xeW9LUkRkMFlU?=
 =?iso-2022-jp?B?K1A3bkVjalczdEdIOEVzeHNiZThkeEx1WjNiMW00dHFxTE5reGpvTFly?=
 =?iso-2022-jp?B?U0tudW1tLyt4K1BYaDZ5TkFXZmM2SXJwa3lMc1M3QmNtVVR4U2hIMkJx?=
 =?iso-2022-jp?B?bS9Ic0ZkZ0lWUE5xSHRuamlzWmlRVy9ibk1DWmVqcTJ1Q1ZHRkNGNER0?=
 =?iso-2022-jp?B?Y2I0ZnA0MTRRcm00L0hNQmV5MnVuRU5FSWFrTTJjSXBUNDNRVFA0emhi?=
 =?iso-2022-jp?B?MGJuenFHM2N2SEdCcnQ1OXB6QWpweUpJanhRYzFzUFBUMHpvUUdhSlV5?=
 =?iso-2022-jp?B?UmwwVjIxbVBacm1OdmZrNFVlQkJxaTlMRVdsb1FLd1FYN2k4aGZqUEl1?=
 =?iso-2022-jp?B?bk9XV2VYc3FNYVk5SDF2c0FQOVNtR0R2aG83SWFYcXFJeEFPNlVCRSt5?=
 =?iso-2022-jp?B?Q1ZEY1gzNDFSRDVlWFFSZ1hCVmp2NHFPY3c2ejNQT21Ma1dZS1I4WUk0?=
 =?iso-2022-jp?B?c2ZGbTNZd1d1eUtEUGNBOEtUVWQzRVEzaitDV3lKbGFjMkJYTkVJWXUv?=
 =?iso-2022-jp?B?ekI2Tk1UR3dWMFUyOG51bHo1QzBFV2wrbmJXV0twd1AyUitnVEJpM1lY?=
 =?iso-2022-jp?B?MnIxTE5LdHN6L2hQanhRbzB6RDRGSy9mb1Noa2NVcVBvd3dmODBVVmd2?=
 =?iso-2022-jp?B?WXRSbUdseEhyRlYydU4wb3hieit2YXh3d3diT1R5bmhKblRuQnArRkp3?=
 =?iso-2022-jp?B?NWUzRVVnUEs2VjM2c1pzSHdSNWRnYURibUVyOXBWVXFpOVVTR25YZlVy?=
 =?iso-2022-jp?B?M1U2cUdHdlh5V1JETVByQUxNcjdIc3NNeGJhYTR0R0lrdzkzRmhidU9U?=
 =?iso-2022-jp?B?U3FlVVVWemxIZkh1cEs3RzlCY1JLUmVrSzVrMjkwTjJuVi9mQ09wQS9w?=
 =?iso-2022-jp?B?cUpRaVlSMVRzbEZBUlFYY0t0bEhpc1l3eUE9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: toshiba-tsip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB9669.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 528261ae-4993-44f9-e880-08dd549c5c96
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Feb 2025 06:27:50.0961
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +u1ABwzq7nmA7nX8AfgtVQQx0AgI6MHEa67ZiBYqUTdqdjO0zwIix+ea3PLSNyu3A6TX+C1A5GjUUm/+wcBv1j2i5ju7dBoJ3dsZXObsAlhwi+Iw9BhbE10sjVupFgoQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB8089
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 24 Feb 2025 06:28:04 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17887

Hi,=0A=
=0A=
>No idea why we all missed that regression.=0A=
I guess the reason for this is that we are currently only doing a partition=
 wise reproducibility test for the wic partitions. In this case the partiti=
on UUID does not come into picture as they are only relevant in the context=
 of a disk image.=0A=
=0A=
Anyways, I am preparing a patch to improve the reproducibility test in the =
CI.=0A=
=0A=
Thanks and Regards,=0A=
Adithya Balakumar=0A=
________________________________________=0A=
From: cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org> on beha=
lf of Jan Kiszka via lists.cip-project.org <jan.kiszka=3Dsiemens.com@lists.=
cip-project.org>=0A=
Sent: Monday, February 24, 2025 11:41 AM=0A=
To: balakumar adithya(=1B$B#T#S#I#P=1B(B DITC_DIT-OST); cip-dev@lists.cip-p=
roject.org=0A=
Cc: kunijadar shivanand(=1B$B#T#S#I#P=1B(B DITC_DIT-OST); ashrith sai(=1B$B=
#T#S#I#P=1B(B DITC_DIT-OST); dinesh kumar(=1B$B#T#S#I#P=1B(B DITC_DIT-OST);=
 hayashi kazuhiro(=1B$BNS=1B(B =1B$BOB9(=1B(B =1B$B#D#M#E=1B(B =1B$B!{#D#I#=
G""#M#P#S!{#M#P#4=1B(B); Felix Moessbauer=0A=
Subject: Re: [cip-dev] [isar-cip-core][PATCH v1] wic: Set partition UUID fo=
r reproducibility=0A=
=0A=
On 24.02.25 05:45, Adithya.Balakumar@toshiba-tsip.com wrote:=0A=
> From: Adithya Balakumar <adithya.balakumar@toshiba-tsip.com>=0A=
>=0A=
> This was previously handled with a patch[1], but the uuid assignment=0A=
> for some of the wic targets were removed by a subsequent patch[2] (probab=
ly by mistake)=0A=
>=0A=
> [1] https://gitlab.com/cip-project/cip-core/isar-cip-core/-/commit/38703c=
b8e44f0dcdb3a1d7adccd765b861cf1273=0A=
> [2] https://gitlab.com/cip-project/cip-core/isar-cip-core/-/commit/1eb074=
8ac1c7290775a6235f1ff7498d8397c03f=0A=
>=0A=
> Signed-off-by: Adithya Balakumar <adithya.balakumar@toshiba-tsip.com>=0A=
> ---=0A=
>  wic/bbb-efibootguard.wks.in                   | 4 ++--=0A=
>  wic/hihope-rzg2m-efibootguard.wks.in          | 4 ++--=0A=
>  wic/qemu-arm64-efibootguard-secureboot.wks.in | 4 ++--=0A=
>  wic/qemu-arm64-efibootguard.wks.in            | 4 ++--=0A=
>  wic/qemu-riscv64-efibootguard.wks.in          | 4 ++--=0A=
>  wic/x86-uefi-efibootguard-secureboot.wks.in   | 4 ++--=0A=
>  wic/x86-uefi-efibootguard.wks.in              | 4 ++--=0A=
>  7 files changed, 14 insertions(+), 14 deletions(-)=0A=
>=0A=
> diff --git a/wic/bbb-efibootguard.wks.in b/wic/bbb-efibootguard.wks.in=0A=
> index e6c3e15..6c30a8a 100644=0A=
> --- a/wic/bbb-efibootguard.wks.in=0A=
> +++ b/wic/bbb-efibootguard.wks.in=0A=
> @@ -15,7 +15,7 @@ part --source rawcopy --sourceparams "file=3D${IMAGE_FU=
LLNAME}.${RO_ROOTFS_TYPE}"=0A=
>  part --source empty --align 1024 --fixed-size 1G --uuid "${ABROOTFS_PART=
_UUID_B}" --part-type 0FC63DAF-8483-4772-8E79-3D69D8477DE4 --part-name syst=
emb=0A=
>=0A=
>  # home and var are extra partitions=0A=
> -part /home --source rootfs --change-directory=3Dhome --fstype=3Dext4 --l=
abel home --align 1024  --size 1G --fsuuid 1f55d66a-40d8-11ee-be56-0242ac12=
0002=0A=
> -part /var --fstype=3Dext4 --label var --align 1024  --size 2G --fsuuid 9=
6be3374-4258-11ee-be56-0242ac120002=0A=
> +part /home --source rootfs --change-directory=3Dhome --fstype=3Dext4 --l=
abel home --align 1024  --size 1G --fsuuid 1f55d66a-40d8-11ee-be56-0242ac12=
0002 --uuid c07d5e8f-3448-46dc-9c0f-58904f369524=0A=
> +part /var --fstype=3Dext4 --label var --align 1024  --size 2G --fsuuid 9=
6be3374-4258-11ee-be56-0242ac120002 --uuid 9947ed57-102f-4038-880c-9cf5caca=
f153=0A=
>=0A=
>  bootloader --ptable gpt --append=3D"rootwait console=3DttyO0,115200 omap=
_wdt.early_enable=3D1 omap_wdt.nowayout=3D1 watchdog.handle_boot_enabled=3D=
0"=0A=
> diff --git a/wic/hihope-rzg2m-efibootguard.wks.in b/wic/hihope-rzg2m-efib=
ootguard.wks.in=0A=
> index fb3f090..311fbd0 100644=0A=
> --- a/wic/hihope-rzg2m-efibootguard.wks.in=0A=
> +++ b/wic/hihope-rzg2m-efibootguard.wks.in=0A=
> @@ -8,7 +8,7 @@ part --source empty --align 1024 --fixed-size 1G --uuid "=
${ABROOTFS_PART_UUID_B}=0A=
>=0A=
>  # home and var are extra partitions=0A=
>=0A=
> -part /home --source rootfs --change-directory=3Dhome --fstype=3Dext4 --l=
abel home --align 1024  --size 1G --extra-space=3D100M --fsuuid 1f55d66a-40=
d8-11ee-be56-0242ac120002=0A=
> -part /var --fstype=3Dext4 --label var --align 1024 --fixed-size 2G --fsu=
uid 96be3374-4258-11ee-be56-0242ac120002=0A=
> +part /home --source rootfs --change-directory=3Dhome --fstype=3Dext4 --l=
abel home --align 1024  --size 1G --extra-space=3D100M --fsuuid 1f55d66a-40=
d8-11ee-be56-0242ac120002 --uuid 43a29d19-005f-49d9-9108-51ad0861d724=0A=
> +part /var --fstype=3Dext4 --label var --align 1024 --fixed-size 2G --fsu=
uid 96be3374-4258-11ee-be56-0242ac120002 --uuid 7e20a7d5-5578-4ced-a7f1-5ee=
494dbaf72=0A=
>=0A=
>  bootloader --ptable gpt --append=3D"console=3Dtty0 console=3DttySC0,1152=
00 rootwait earlyprintk"=0A=
> diff --git a/wic/qemu-arm64-efibootguard-secureboot.wks.in b/wic/qemu-arm=
64-efibootguard-secureboot.wks.in=0A=
> index 00d627d..955a6b6 100644=0A=
> --- a/wic/qemu-arm64-efibootguard-secureboot.wks.in=0A=
> +++ b/wic/qemu-arm64-efibootguard-secureboot.wks.in=0A=
> @@ -4,7 +4,7 @@ part --source rawcopy --sourceparams "file=3D${IMAGE_FULL=
NAME}.verity" --align 102=0A=
>  part --source empty --align 1024 --fixed-size 1G --uuid "${ABROOTFS_PART=
_UUID_B}" --part-type 0FC63DAF-8483-4772-8E79-3D69D8477DE4 --part-name syst=
emb=0A=
>=0A=
>  # home and var are extra partitions=0A=
> -part /home --source rootfs --change-directory=3Dhome --fstype=3Dext4 --l=
abel home --align 1024 --size 1G --fsuuid 1f55d66a-40d8-11ee-be56-0242ac120=
002=0A=
> -part /var  --fstype=3Dext4 --label var  --align 1024 --fixed-size 2G --f=
suuid 96be3374-4258-11ee-be56-0242ac120002=0A=
> +part /home --source rootfs --change-directory=3Dhome --fstype=3Dext4 --l=
abel home --align 1024 --size 1G --fsuuid 1f55d66a-40d8-11ee-be56-0242ac120=
002 --uuid e869413d-dc84-4822-b50d-00c5aab7d6fc=0A=
> +part /var  --fstype=3Dext4 --label var  --align 1024 --fixed-size 2G --f=
suuid 96be3374-4258-11ee-be56-0242ac120002 --uuid 815406da-387f-4e89-a0fb-6=
e617605c8c3=0A=
>=0A=
>  bootloader --ptable gpt --append=3D"panic=3D5"=0A=
> diff --git a/wic/qemu-arm64-efibootguard.wks.in b/wic/qemu-arm64-efibootg=
uard.wks.in=0A=
> index 17434d1..ce6253e 100644=0A=
> --- a/wic/qemu-arm64-efibootguard.wks.in=0A=
> +++ b/wic/qemu-arm64-efibootguard.wks.in=0A=
> @@ -7,7 +7,7 @@ part --source rawcopy --sourceparams "file=3D${IMAGE_FULL=
NAME}.${RO_ROOTFS_TYPE}"=0A=
>  part --source empty --align 1024 --fixed-size 1G --uuid "${ABROOTFS_PART=
_UUID_B}" --part-type 0FC63DAF-8483-4772-8E79-3D69D8477DE4 --part-name syst=
emb=0A=
>=0A=
>  # home and var are extra partitions=0A=
> -part /home --source rootfs --change-directory=3Dhome --fstype=3Dext4 --l=
abel home --align 1024  --size 1G --fsuuid 1f55d66a-40d8-11ee-be56-0242ac12=
0002=0A=
> -part /var --fstype=3Dext4 --label var --align 1024 --fixed-size 2G --fsu=
uid 96be3374-4258-11ee-be56-0242ac120002=0A=
> +part /home --source rootfs --change-directory=3Dhome --fstype=3Dext4 --l=
abel home --align 1024  --size 1G --fsuuid 1f55d66a-40d8-11ee-be56-0242ac12=
0002 --uuid 7346faa7-d6d4-49fa-a03e-82ee469cb1e5=0A=
> +part /var --fstype=3Dext4 --label var --align 1024 --fixed-size 2G --fsu=
uid 96be3374-4258-11ee-be56-0242ac120002 --uuid 423f0a2e-b9b3-4615-85be-2a4=
261fa32d9=0A=
>=0A=
>  bootloader --ptable gpt=0A=
> diff --git a/wic/qemu-riscv64-efibootguard.wks.in b/wic/qemu-riscv64-efib=
ootguard.wks.in=0A=
> index 1a2291e..1166ea1 100644=0A=
> --- a/wic/qemu-riscv64-efibootguard.wks.in=0A=
> +++ b/wic/qemu-riscv64-efibootguard.wks.in=0A=
> @@ -7,7 +7,7 @@ part --source rawcopy --sourceparams "file=3D${IMAGE_FULL=
NAME}.${RO_ROOTFS_TYPE}"=0A=
>  part --source empty --align 1024 --fixed-size 1G --uuid "${ABROOTFS_PART=
_UUID_B}" --part-type 0FC63DAF-8483-4772-8E79-3D69D8477DE4 --part-name syst=
emb=0A=
>=0A=
>  # home and var are extra partitions=0A=
> -part /home --source rootfs --change-directory=3Dhome --fstype=3Dext4 --l=
abel home --align 1024  --size 1G --fsuuid 1f55d66a-40d8-11ee-be56-0242ac12=
0002=0A=
> -part /var --fstype=3Dext4 --label var --align 1024  --fixed-size 2G --fs=
uuid 96be3374-4258-11ee-be56-0242ac120002=0A=
> +part /home --source rootfs --change-directory=3Dhome --fstype=3Dext4 --l=
abel home --align 1024  --size 1G --fsuuid 1f55d66a-40d8-11ee-be56-0242ac12=
0002 --uuid e578254c-bd99-4442-bc51-4935cd0ef522=0A=
> +part /var --fstype=3Dext4 --label var --align 1024  --fixed-size 2G --fs=
uuid 96be3374-4258-11ee-be56-0242ac120002 --uuid 0209689d-672f-4254-8b92-56=
6d6d9fd1ae=0A=
>=0A=
>  bootloader --ptable gpt=0A=
> diff --git a/wic/x86-uefi-efibootguard-secureboot.wks.in b/wic/x86-uefi-e=
fibootguard-secureboot.wks.in=0A=
> index 0f4d637..71b0103 100644=0A=
> --- a/wic/x86-uefi-efibootguard-secureboot.wks.in=0A=
> +++ b/wic/x86-uefi-efibootguard-secureboot.wks.in=0A=
> @@ -4,7 +4,7 @@ part --source rawcopy --sourceparams "file=3D${IMAGE_FULL=
NAME}.verity" --align 102=0A=
>  part --source empty --align 1024 --fixed-size 1G --uuid "${ABROOTFS_PART=
_UUID_B}" --part-type 0FC63DAF-8483-4772-8E79-3D69D8477DE4 --part-name syst=
emb=0A=
>=0A=
>  # home and var are extra partitions=0A=
> -part /home --source rootfs --change-directory=3Dhome --fstype=3Dext4 --l=
abel home --align 1024 --size 1G --fsuuid 1f55d66a-40d8-11ee-be56-0242ac120=
002=0A=
> -part /var  --fstype=3Dext4 --label var  --align 1024 --fixed-size 2G --f=
suuid 96be3374-4258-11ee-be56-0242ac120002=0A=
> +part /home --source rootfs --change-directory=3Dhome --fstype=3Dext4 --l=
abel home --align 1024 --size 1G --fsuuid 1f55d66a-40d8-11ee-be56-0242ac120=
002 --uuid 94593121-6f5f-4b04-98db-39aace692682=0A=
> +part /var  --fstype=3Dext4 --label var  --align 1024 --fixed-size 2G --f=
suuid 96be3374-4258-11ee-be56-0242ac120002 --uuid 686a2e06-7f96-495b-beac-1=
731cb98eb0e=0A=
>=0A=
>  bootloader --ptable gpt --append=3D"console=3Dtty0 console=3DttyS0,11520=
0 rootwait earlyprintk watchdog.handle_boot_enabled=3D0 iTCO_wdt.nowayout=
=3D1 panic=3D5"=0A=
> diff --git a/wic/x86-uefi-efibootguard.wks.in b/wic/x86-uefi-efibootguard=
.wks.in=0A=
> index 9d344f8..962eaac 100644=0A=
> --- a/wic/x86-uefi-efibootguard.wks.in=0A=
> +++ b/wic/x86-uefi-efibootguard.wks.in=0A=
> @@ -8,7 +8,7 @@ part --source empty --align 1024 --fixed-size 1G --uuid "=
${ABROOTFS_PART_UUID_B}=0A=
>=0A=
>  # home and var are extra partitions=0A=
>=0A=
> -part /home --source rootfs --change-directory=3Dhome --fstype=3Dext4 --l=
abel home --align 1024  --size 1G --extra-space=3D100M --fsuuid 1f55d66a-40=
d8-11ee-be56-0242ac120002=0A=
> -part /var --fstype=3Dext4 --label var --align 1024 --fixed-size 2G --fsu=
uid 96be3374-4258-11ee-be56-0242ac120002=0A=
> +part /home --source rootfs --change-directory=3Dhome --fstype=3Dext4 --l=
abel home --align 1024  --size 1G --extra-space=3D100M --fsuuid 1f55d66a-40=
d8-11ee-be56-0242ac120002 --uuid f12faa7c-a9ef-4b3f-b63d-1c74bd5c2b1c=0A=
> +part /var --fstype=3Dext4 --label var --align 1024 --fixed-size 2G --fsu=
uid 96be3374-4258-11ee-be56-0242ac120002 --uuid be5ae5e0-91d3-46ec-a7f7-c1e=
bfc0a7c28=0A=
>=0A=
>  bootloader --ptable gpt --append=3D"console=3Dtty0 console=3DttyS0,11520=
0 rootwait earlyprintk watchdog.handle_boot_enabled=3D0 iTCO_wdt.nowayout=
=3D1 "=0A=
=0A=
No idea why we all missed that regression. Thanks, applied.=0A=
=0A=
Jan=0A=
=0A=
--=0A=
Siemens AG, Foundational Technologies=0A=
Linux Expert Center=0A=


