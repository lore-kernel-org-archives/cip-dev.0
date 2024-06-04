Return-Path: <nobuhiro1.iwamatsu@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 588FBC25B7E
	for <webhook@archiver.kernel.org>; Tue,  4 Jun 2024 07:38:49 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.135])
 by mx.groups.io with SMTP id smtpd.web11.15777.1717486726780815279
 for <cip-dev@lists.cip-project.org>;
 Tue, 04 Jun 2024 00:38:48 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro1.iwamatsu@toshiba.co.jp header.s=key2.smx header.b=f29l4oe4;
 spf=pass (domain: toshiba.co.jp, ip: 210.130.202.135, mailfrom: nobuhiro1.iwamatsu@toshiba.co.jp)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=toshiba.co.jp;h=From:To:CC
	:Subject:Date:Message-ID:References:In-Reply-To:Content-Type:
	Content-Transfer-Encoding:MIME-Version;i=nobuhiro1.iwamatsu@toshiba.co.jp;s=
	key2.smx;t=1717486724;x=1718696324;bh=qPEfPABt/F2qrKIGIn8NK5iV8gvR6Ozw6oRlRyu
	GkUA=;b=f29l4oe4+b3D28lkpOm6V6pSkMWmvE3QtIg1wB5FdpvoXzE+WcsMdZzWS6+rncf/myCn2
	8MH5u5X23BQ2Rp7Z4dDrsVe1UumsBHyhwsiZo2OYQ1OrmvjaYfSqQEJzqt5iweswzKyjZBVjdRz57
	M8HEhSSFJ0ULzBx9+VVtVxd3h6ccLy1piu4SeU5+YlpsWCOk1Fr+iaoksoQfVt5RhxUQ47vvG3e4S
	uuCyiK4vWkmNVAolMuubLbpB4SgiUaocfldFLQUBHqEL5/53ffAtwV7U0E4dajTmsiC09M+6nO0RB
	ixTYBIuO0dTh22dPv4TK0fk7MSuUL5uYU1awpevaHw==;
Received: by mo-csw.securemx.jp (mx-mo-csw1801) id 4547ciKZ1255854; Tue, 4 Jun 2024 16:38:44 +0900
X-Iguazu-Qid: 2yAbNsrDKa2dqZTbet
X-Iguazu-QSIG: v=2; s=0; t=1717486724; q=2yAbNsrDKa2dqZTbet; m=tte0fnGFvCOf9ijypR/0F/yo1kx+POS0J9j5U1b5YvA=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1800) id 4547chP53574030
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Tue, 4 Jun 2024 16:38:44 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cRjpSUTFmlW5OS99+xfc0zN1o3Z1D/yC7knbJzzZ766lqwdIDEPilTcBrdKNaoG4YZJlJyZDSrrovMCNYcldwO5aCajpwaNdCZsFssRMrDKFPJ6FQo85z0PVrrPU7N4wfNOXsU1chEb/+6FkI7d7ODcG4RihI904uSgUFa3TsoL4wPC3OIO9tvXOy8vwmgViu8kc3Lgvsgk+SDiapyZQ4fB/CjRyDXTn77E9U3MQtcDAxGffrO5bS3SJeDEk1fAe5emQnMCiW+Z5BBUm5FVufX1adj2N70dMIsRNRYX8tY7/2hlr/V7GymAKqGbVZ8iuQTrnj2RAiGhkaNgt4fsGbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9V24mD0wrVIvtQQMTv3hILS7K5WBm3ulystRMJL9/PA=;
 b=EFU+++8Pjd5Pov7Qc51Kjq3PunIsUcHccuerJlOq9igQuzJP3nR4JWacKc8nwQAIs73e0fVIrkCFIrXVd7tzCSVdm5YzFIdBkRd2hP7UGQ1N3raRFsYxZ0cs/TAPsYV3mmoTB/b01mAKcVcwF3x3Y3sD9nIe8HQQ+cSLBL894I4b240S4NM+Ld9s+E+by599Wj+3U6otZIhaRy8tQRdhO15kB4nQxxBED69jYly7znea7CKHYyRxpVRi/cOO9c3QMZ8iVDn5ZCmhISrhjC5YCmvUKVI5QDRz0ycmkeNI5SA3l2bWXFG54wG3aqFvQfWka3GKQsL+0q0hUwqyTld04Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <Adithya.Balakumar@toshiba-tsip.com>
CC: <cip-dev@lists.cip-project.org>
Subject: RE: Preparing test evidences for CIP Core packages for IEC 62443-4-x
 assessment
Thread-Topic: Preparing test evidences for CIP Core packages for IEC 62443-4-x
 assessment
Thread-Index: AdqngyKNF2gl+sOgQmW8Zvoy0bqzgANdasWwAFYMJNA=
Date: Tue, 4 Jun 2024 07:38:40 +0000
X-TSB-HOP2: ON
Message-ID: 
 <OS0PR01MB6388896562B9D39ABC38646892F82@OS0PR01MB6388.jpnprd01.prod.outlook.com>
References: <17CFF53CC1142B4C.16299@lists.cip-project.org>
 <TYCPR01MB96695706DE27A0CADA000C27C4FE2@TYCPR01MB9669.jpnprd01.prod.outlook.com>
In-Reply-To: 
 <TYCPR01MB96695706DE27A0CADA000C27C4FE2@TYCPR01MB9669.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB6388:EE_|OS3PR01MB7970:EE_
x-ms-office365-filtering-correlation-id: 2b57da00-6bec-4994-c8f6-08dc84695a98
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230031|376005|1800799015|366007|38070700009|95630200002;
x-microsoft-antispam-message-info: 
 =?iso-2022-jp?B?MTlKTnlGUGJMZ29KOVIvdWp1ZEM5ZXJxemovaEduU2VndjhoK0pBMXRs?=
 =?iso-2022-jp?B?QWhVbDZ5WmpRYXhWbFBHVmEzWkhwUTRFV0gyTUE4N1M1NmtOeUdsUXhs?=
 =?iso-2022-jp?B?UlF1WjRWeTcyMXRsR2FuR0NFL045cS8yVE5FYTdVVEJYZkt2QmFDY1ZT?=
 =?iso-2022-jp?B?a01Ta2Q1Tkhqa204VVk4aDJzRkFuYk9ucUcxL2FlSGthSW9pNlN1TjZV?=
 =?iso-2022-jp?B?UTlmblFZcWRTVVFRM2pKTEtINmVwMVUyLzM4NjNnNEJ4ZjdvN2kzcU9F?=
 =?iso-2022-jp?B?R091MXlCa1lWQm43NW1VVGNDNG83dHFPZk0yOTBad0EwUVFLQ3d3K0lT?=
 =?iso-2022-jp?B?bEFDMjd5U1B2WkVLeFdnMkdZSkh0SFBxZDJtTGxZcmlJMlE1UW52RmdP?=
 =?iso-2022-jp?B?YURIQ1R2OFdMWEpwSGk1T0ErMlpXclp5SzI2eDYzVXpmN1d4dE9OOG4v?=
 =?iso-2022-jp?B?bzNndUREdFZZTk15NWowWnl2Rnl1N213OThIYWNOY0ZvaWQrT01odWlH?=
 =?iso-2022-jp?B?WVUraWJjUnk2UWZ3UkcvUHRqSW40OWJMZ2tzaFV4Z2NpejV1VlNKKy9v?=
 =?iso-2022-jp?B?SHV0ZWJvOUFwOXVRVXc0ZEVCMnlWNlRxQVJsa3M5cEJraVpWV3piQWcz?=
 =?iso-2022-jp?B?aE1SSFVLYm5YT0gvM29nWUZCRk1FUnRQb0xPWkxNblhIUWw2ZnlScEFn?=
 =?iso-2022-jp?B?U2NvSHFkanJNaENrYXg2QlZYZFJMYkQzcjB0VTRBMUNldFFmVllWKzIz?=
 =?iso-2022-jp?B?RU9kbldReHIxTVhrYnovNXJ1dWNlRjhqbEMzSUc5ckQyUzdBNmJTMGN1?=
 =?iso-2022-jp?B?K1dSVHRCckFjb3NKYmpKZW1scFRzdDdPYzIzc0VzTlhHaW5BSWJPS3Rq?=
 =?iso-2022-jp?B?TFRiWGp0OEt3ZE9lWWJEVndhTTlUQXlCQ0IrSEtwT0poMlVkOEZXeTRi?=
 =?iso-2022-jp?B?TXdIVTJWTVNqQTRuSFAxc0VDRUxJUngzMFpDK21aS3NleGpzYldlamg3?=
 =?iso-2022-jp?B?YWhLK2tZMVpCSFFaaVg2Q0lmZG5IL2hCK3ZtbVh5WThVWXIyc1pDSjNS?=
 =?iso-2022-jp?B?N0EydjVsQ0ZtVldsc0dnTnB6ZzhPTmVuczN5N0hlUVQyTGkxVHB0MEdL?=
 =?iso-2022-jp?B?SEpPcjBmeTZNc3gzejZCTnM1Y1k5bEhiTmhabGRtYWVSTTQ0SDBvY2d4?=
 =?iso-2022-jp?B?UzFpa2pGZWRLUkdvbEl5T3dMQ3p5RXZaMC9iK1RKTVVtenMvVFhQb1F3?=
 =?iso-2022-jp?B?UGZqOW1ZajVOcllSUmlRUmN6V091akVWeDV1c0N1ZUw5QjdyaUhIRHh4?=
 =?iso-2022-jp?B?aG5VblplQ0ZTZUs0WjdyT2FQMHBXVVA1Y1hqeTFIUWFhUlJDbXMvMW1S?=
 =?iso-2022-jp?B?bEphSVZRQzFTNG9qTmZqZnd2THZUWTlWUWtuci9rTjM0clRCb2grTEJB?=
 =?iso-2022-jp?B?NGUxeXBsWHNOMVN0QlljRVdDVE0wQU1iYllPc21kWUpsOEVsSDNWVkxW?=
 =?iso-2022-jp?B?YU42cXhzY1V3Mk9qWFRkNFFSUDUrVXF3TGgwSUdxV1AyR1dUaW1wZVFH?=
 =?iso-2022-jp?B?YURIVTNqUXBmMmVYcTI1NDIzc0kwZmlxMmlUSnZnbTNzSFVNekFJVFRB?=
 =?iso-2022-jp?B?L0VxQzVnZkdGVUh4cUtRUk96YTZuTlozRGh5SW5LTjltVzRUR3lYbWVN?=
 =?iso-2022-jp?B?SkkzdXBXSmtNVkhwK2RWbkNoS0pRZWRyUUFuQTU1VUwvNi8va1pYbUU5?=
 =?iso-2022-jp?B?cDJEOXovSWt0K0ZraU9ya2kyR3pBVVlkcWJIT0xmSzBpcGhnQWVJZ09y?=
 =?iso-2022-jp?B?QnZEcFFHM0VoRzdmaFhSMk9YVy92azJFUDVEOGdrVnBibEZxT2xRUm5z?=
 =?iso-2022-jp?B?K2szYUpDeEwvcHJ4YjZGcitETSsyQk5uc3BrOFF4S1lNTU5SUXNOMmFU?=
 =?iso-2022-jp?B?ZUxsclZ6cmd1dU56Y0NlOVpSOW5td1p5UUFzTFJuYTVvblVjb0NPYUd0?=
 =?iso-2022-jp?B?ST0=?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB6388.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007)(38070700009)(95630200002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?TUhKT3NvcDNhalV3YWtQYzUvK1pxR2F1bEJxY3hJdndpY1V5RkxXdlFF?=
 =?iso-2022-jp?B?SmhMbERmTWl4V1J5cUFnbVZndDRjNXBaV25xM0E4eE1xUi9VYit0NGFK?=
 =?iso-2022-jp?B?U0twRTJXdnBtVWkrbldzUUZHbis1MjR2OWxzWXZzbytMeG5xTDBVemdo?=
 =?iso-2022-jp?B?RVVSRVVSNzZtSFlhdS9CZ3l3RWlFTGM2enhrOEk3cWNncWZ3OVZONGVM?=
 =?iso-2022-jp?B?aEpzWWdZVjJ1cFIvMXlXYldmOTlLN0ZCZnJZQmsrOUViYU9kR0dvdHVN?=
 =?iso-2022-jp?B?Uzl3a0c5Mm1TbmZrZkVTamtrdkdNcTduWGZsd3l0Q1ZHTmJsU0VTeFFN?=
 =?iso-2022-jp?B?cCt4U2hEbDVNWUc3YnUxc3VqSHFrZ0licnRzWVRmbXQ2dzRxZnNQMXhO?=
 =?iso-2022-jp?B?NTMrYUh6TlV3cEkvMW9mT0htWklGdytJdWpnUVBUcitVVXhidENEcEEw?=
 =?iso-2022-jp?B?aGVvWE5OTzJaRkdVN21TZUUxb2tUeE5QRWl4SzhlUkRCaGlSa0N3T25m?=
 =?iso-2022-jp?B?Zy9HYjhTRDR2THMzZjl0ZmdWVDZXa2hjUjk0RFU3aktqeWpvY2lEaWc4?=
 =?iso-2022-jp?B?U0NWL3RHS3Q4Yi9FdDA2UzdjdTVNUmtmSXdENXp3VXk4NXh4UytDQ0ky?=
 =?iso-2022-jp?B?WEdGb2hCVWpwZFpXR1hvekJrSmRxN2ZoaE9lQk1BSGZXYWt5Rm5jWks4?=
 =?iso-2022-jp?B?bnp2V3FFSG81QU1BcTlmR2N2bHQ3ckNaMnY3MmxwT2FHQXVOUHdITHlC?=
 =?iso-2022-jp?B?TkphaTEyTjBkRmtEN3ZIODVzQThJS0w0d3lUMi9nYzkvWmx5NjdoQVN6?=
 =?iso-2022-jp?B?SnZRckszVHl2cXAySGczK0puNEZObFNTOW9TSlhSWWp5SDlxWGJLbjN3?=
 =?iso-2022-jp?B?WFlOeVFweU1QZFREWTdNUVljNnhkVVpGR3ZicW9VMGFIbWVoK0ZMakV0?=
 =?iso-2022-jp?B?RkpKdlZySkw4QzY4OWN2WFdmR1NpckpCS00vL1BZc1B4clNTcTU5eGVQ?=
 =?iso-2022-jp?B?bGpnTTRaQlNZdHlMOXhkNEVObGV0akdZOGFQTE51QUFqOFhacDk1cTNy?=
 =?iso-2022-jp?B?eFo0SlRZTmFsT2M3ZG1La0kyeFEvejEvekJlVHNFZ0plUlhGTTFuaG1n?=
 =?iso-2022-jp?B?TVA0NjBDWDdGMzZaUmpTVmdUckh5K3dnT0NSazM0RzlWM05sS094czE1?=
 =?iso-2022-jp?B?K3BpeGphajhGWEx6VTlvaG53aE5OUVRLOS91aU52RDFjclhiR3JyTC9O?=
 =?iso-2022-jp?B?Y0lwQWIyVjFsYU54MDVhMFlyRVdBQW16dm1ZdFNuQklWS2VJczd3NURk?=
 =?iso-2022-jp?B?clgwaHFwQ3J6ckxpRS9TbmhScUF3Zi9kTHB2NVRDVUtqdWFqcXh0Q3JS?=
 =?iso-2022-jp?B?Skw1UlVtZEZVOFNHaUN5OCtJOGdxNktGVzlhbklhWDA1c2xDNGF6MEEv?=
 =?iso-2022-jp?B?RGhkaUtaUTk5TS91eTFWcXJmS3NLNXBhZXBOME90cHVnTmEwSEs3bmxW?=
 =?iso-2022-jp?B?VFVLWS9KNHN6UFdmMCtoR0ROTVlYMEwySGRDeDBMTFMzWkFYbzlxOHZT?=
 =?iso-2022-jp?B?N1JSaGlRempCWGg0NFBlUnprcnBodGk4UmdJdlBrUWswNHZBSFBSR0VT?=
 =?iso-2022-jp?B?MFVFVjRNMkdVTHlEeENmTTlYQUxKWjlpZ1NhZ3Jjang0ekxzamY3aHB3?=
 =?iso-2022-jp?B?VlQ5Vk9iZzhJbHhtc1h6eEtpMlJIcmpHUE84NG1Zd0tGRXFhdGdMRGlr?=
 =?iso-2022-jp?B?Skg5eWQ0cWRIMUk3UWFqcCtLVm1PR2s0WkRpbWc5OTZ1WVVuaDUrRXpo?=
 =?iso-2022-jp?B?YUFZME9OblY4Y3JaT011d2NUT0t4UWpLVWI3V3pVMVR5bHlOdThxRFEv?=
 =?iso-2022-jp?B?dEZNN1ordWMybHFmeXVtNUhDc1ZkOUtwcll0TDFZSXRWS051OFRPWFpE?=
 =?iso-2022-jp?B?c1h1V1hwV2FmY21NQnR6RjZzdjdiUmM5WkFad3k2bVVCN2RHYUxqNlZx?=
 =?iso-2022-jp?B?dFFEYWxNZ0VMMTdRSWlaV2NDTXFDeXlzL20zYTJuOGlMSEJjRWZRY21v?=
 =?iso-2022-jp?B?UXMxaWoxbzRxcDkxRGhuMy9sZTlJTHd3NVBHcVlsSGY4KzlocEl0cVZQ?=
 =?iso-2022-jp?B?L2VxMGd2RzBWNkJrUGF2SHNxVW5nNGtPYlBCbXp4Y0hpSnE4clZ2MGl5?=
 =?iso-2022-jp?B?NkM5OG1ldXN4a0dJLzlBVDVUOWlVbzRhdEZOcXFFK00zSzJmQ0orYnpB?=
 =?iso-2022-jp?B?ajM5Y0h1RFF2Mlc2ZklXMVhEbS95Q2NkVi93Z2JZRFVRb3F6aGY1VnF3?=
 =?iso-2022-jp?B?WkZlMHhIYVFZVnV1Z2hERGVUS3FHSUhWZGtuSnZ1Y093aDM5S1Mwb253?=
 =?iso-2022-jp?B?Z0tWdWFuMktWb3Y4Qk1nMnNDTmRNeEx5MFBra1U0RUl3azJ6ODB4V2Vn?=
 =?iso-2022-jp?B?d1diYVU4b29wT2JjWjlINDk1TUdJNGpzNWMwPQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: toshiba.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB6388.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b57da00-6bec-4994-c8f6-08dc84695a98
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jun 2024 07:38:40.5568
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YXyMEhLosjSlYau2hj3efKg9pHnDikt1osrr5HReckBnU4Bo4Ewi8hWqRHDV14LGtHZP3+nTF/Q+fkQjcHBvWJx3XsoENR2nTPrB5+EGt0agAhcmpJTukt0U+HU+wEvd
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB7970
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 04 Jun 2024 07:38:49 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16100

Hi,

> As suggested by you in the previous TSC meeting, we are looking for any t=
ests available for the above packages in other distributions as well. So fa=
r, we have checked ubuntu, where we found a test suite for the net-tools pa=
ckage. The rest of the packages do not have tests defined in ubuntu as well=
.
>=20
> We would like to understand your opinion on the next steps to take or oth=
er distributions to target for tests for the above listed packages.

First, we need to think about what kind of testing is needed for each packa=
ge. The base-files=20
package provides Debian suite information and others, and we need to think =
about how it needs
to be tested.
Next, check the Debian BTS. There may already be a bug report for autopkgte=
sts. If the bug has
not been reported to the BTS, create an autopkgtest and report it with the =
BTS.
For example, the net-tools package is in ubuntu, so we can file a bug reque=
sting that it be included.
BTS, there do not seem to be any bug reports for this package.
  https://bugs.debian.org/cgi-bin/pkgreport.cgi?repeatmerged=3Dno&src=3Dnet=
-tools

Best regards,
  Nobuhiro

> -----Original Message-----
> From: balakumar adithya(=1B$B#T#S#I#P=1B(B TEUR)
> <Adithya.Balakumar@toshiba-tsip.com>
> Sent: Sunday, June 2, 2024 11:27 PM
> To: iwamatsu nobuhiro(=1B$B4d>>=1B(B =1B$B?.MN=1B(B =1B$B!{#D#I#T#C""#D#I=
#T!{#O#S#T=1B(B)
> <nobuhiro1.iwamatsu@toshiba.co.jp>
> Cc: cip-dev@lists.cip-project.org
> Subject: RE: Preparing test evidences for CIP Core packages for IEC 62443=
-4-x
> assessment
>=20
> Hello Iwamatsu-san,
>=20
>=20
>=20
> Sorry to bother you again.
>=20
>=20
>=20
> Just wanted to follow up on the previous mail regarding the test evidence=
s for
> CIP Core packages.
>=20
> Would like to know if you have any suggestions on which other distributio=
ns to
> look into for packages that do not have tests defined in Debian Salsa or
> upstream.
>=20
>=20
>=20
> Thanks and Regards,
>=20
> Adithya Balakumar
>=20
>=20
>=20
> From: cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org> On
> Behalf Of Adithya Balakumar
> Sent: Thursday, May 16, 2024 5:10 PM
> To: iwamatsu nobuhiro(=1B$B4d>>=1B(B =1B$B?.MN=1B(B =1B$B!{#D#I#T#C""#D#I=
#T!{#O#S#T=1B(B)
> <nobuhiro1.iwamatsu@toshiba.co.jp>
> Cc: cip-dev@lists.cip-project.org
> Subject: [cip-dev] Preparing test evidences for CIP Core packages for IEC
> 62443-4-x assessment
>=20
>=20
>=20
> Hello Iwamatsu-san,
>=20
>=20
>=20
> Hope this message finds you well.
>=20
>=20
>=20
> We at the CIP Security Workgroup have been working to collect test eviden=
ces
> for CIP Core packages included in CIP Security image as part of IEC 62443=
-4-x
> assessment.
>=20
>=20
>=20
> To summarize the work done by CIP SWG so far, CIP SWG investigated the
> number of packages in CIP Security image and tried to understand the numb=
er
> of packages that have test results available in debian and number of pack=
ages
> for which we have to run the tests ourselves and provide the results. I a=
m
> including the summary of the packages below:
>=20
>=20
>=20
> *         Total packages in CIP Security image - 242
>=20
>=20
>=20
> *         Custom CIP packages (from isar-cip-core recipes) ? 13
>=20
> o   These packages are created by recipes in isar-cip-core or isar that a=
re
> deployed into image as a .deb file.
>=20
>=20
>=20
> *         Packages with Debian CI autopkgtest - 140
>=20
> o   97 packages with functional tests, 41 packages with non-functional te=
sts,
> 2 packages with no tests running in debian CI
>=20
>=20
>=20
> *         Packages without tests in Debian CI ? 89
>=20
> o   70 packages have tests available either in debian salsa or upstream.
>=20
>=20
>=20
> *         Packages without tests in upstream as well ? 19
>=20
>=20
>=20
> There are a few packages that do not have tests defined in either debian =
salsa
> or upstream. I am listing the packages that do not have tests defined in =
either
> debian salsa or upstream below:
>=20
>=20
>=20
> Binary Package name
>=20
> Source package name
>=20
> Are there Debian CI results ?
>=20
> Are upstream tests available
>=20
> Remarks
>=20
> base-files
>=20
> base-files
>=20
> NO
>=20
> NO
>=20
>=20
>=20
> base-passwd
>=20
> base-passwd
>=20
> NO
>=20
> NO
>=20
>=20
>=20
> hostname
>=20
> hostname
>=20
> NO
>=20
> NO
>=20
>=20
>=20
> libmnl0
>=20
> libmnl
>=20
> NO
>=20
> NO
>=20
>=20
>=20
> libnsl2
>=20
> libnsl
>=20
> NO
>=20
> NO
>=20
>=20
>=20
> libpam-passwdqc
>=20
> passwdqc
>=20
> NO
>=20
> NO
>=20
>=20
>=20
> libpam-pkcs11
>=20
> pam-pkcs11
>=20
> NO
>=20
> NO
>=20
>=20
>=20
> libpasswdqc1
>=20
> passwdqc
>=20
> NO
>=20
> NO
>=20
>=20
>=20
> libpython3-stdlib
>=20
> python3-defaults
>=20
> NO
>=20
> NO
>=20
>=20
>=20
> libreadline8
>=20
> readline
>=20
> NO
>=20
> NO
>=20
>=20
>=20
> librtmp1
>=20
> rtmpdump
>=20
> NO
>=20
> NO
>=20
>=20
>=20
> linux-base
>=20
> linux-base
>=20
> NO
>=20
> NO
>=20
>=20
>=20
> media-types
>=20
> media-types
>=20
> NO
>=20
> NO
>=20
>=20
>=20
> net-tools
>=20
> net-tools
>=20
> NO
>=20
> NO
>=20
> Few functional tests in ubuntu:
> https://git.launchpad.net/ubuntu/+source/net-tools/tree/debian/tests
> Autopkgtest running in Ubuntu CI
> https://autopkgtest.ubuntu.com/packages/net-tools
> <https://git.launchpad.net/ubuntu/+source/net-tools/tree/debian/tests>
>=20
> python3
>=20
> python3-defaults
>=20
> NO
>=20
> NO
>=20
>=20
>=20
> python3-minimal
>=20
> python3-defaults
>=20
> NO
>=20
> NO
>=20
>=20
>=20
> readline-common
>=20
> readline
>=20
> NO
>=20
> NO
>=20
>=20
>=20
> sysvinit-utils
>=20
> sysvinit
>=20
> NO
>=20
> NO
>=20
>=20
>=20
> tpm-udev
>=20
> tpm-udev
>=20
> NO
>=20
> NO
>=20
>=20
>=20
>=20
> As suggested by you in the previous TSC meeting, we are looking for any t=
ests
> available for the above packages in other distributions as well. So far, =
we have
> checked ubuntu, where we found a test suite for the net-tools package. Th=
e
> rest of the packages do not have tests defined in ubuntu as well.
>=20
> We would like to understand your opinion on the next steps to take or oth=
er
> distributions to target for tests for the above listed packages.
>=20
>=20
>=20
> Thanks and Regards,
> Adithya Balakumar
>=20
>=20



