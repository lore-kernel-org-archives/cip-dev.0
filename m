Return-Path: <sai.sathujoda@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDF52ECE57A
	for <webhook@archiver.kernel.org>; Mon,  9 Sep 2024 12:02:13 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.134])
 by mx.groups.io with SMTP id smtpd.web11.51213.1725883330184197677
 for <cip-dev@lists.cip-project.org>;
 Mon, 09 Sep 2024 05:02:10 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.134, mailfrom: sai.sathujoda@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1800) id 489C27tJ1025294; Mon, 9 Sep 2024 21:02:08 +0900
X-Iguazu-Qid: 2yAacTOYDyyqzEuvlx
X-Iguazu-QSIG: v=2; s=0; t=1725883327; q=2yAacTOYDyyqzEuvlx; m=ZD6LzhYzODGcwES5QoUqYpEI46Q15ArNXHY5avWyAoA=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1800) id 489C265d3458673
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 9 Sep 2024 21:02:07 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CW8XCtgftVajgrmYTm456ZK6NeHdJQt8z1WystBp/YgJgAUfi1kP10Zjc83RvGRPhKssS45OjXGUe0kWCYv1LjyJHxADuHc8T5PCS8dT6juD7GUgLZcZaYpvfq1NZaaYlr5yIxgHAAimsxe+XbpKL7NBhJdJH6n+PCp15+n4LuQ9xq4WWAOvMMhTNLWpJKjETl7A/g4hmv/BCsjickH648qNE6OXX1zsA2aBrDoYNPh4N9rybW9Tn+pUsF1+SjxnFBmUguhY7kmtl28B6v/icQBj+Y6fbOO3vX3YIn3XbV3nlnMGrGjTrQjnC8YkdQ2enhhdMMHBm9ilkfYtLEeBWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BrkuICMjPE+tRlzQplYfI2yq1xxPt/hWG2vSuZueovc=;
 b=zGSU9HLg+Mbz10PwExC1EX6yIXxeyGenfrvZ9LDtGxlaI8PQpXzLHYmXeotYSlUzt9sqy6hB9DPp6ij9ZpOh8Tj/HByrOwEYfn5xW78dupype66smUXHnQCoNMWPOOdqsKPmDObYSgOx24/TbFSIhPWd1uyyrLyVAD0/T8baqJxiS2EO8IQONspqX7R27L1pQecI6DXfl9AIC8JMpWNXs8wIdLeCs9YoeKh+63BmH1Iyx/NcscbF9eU7tM5LjsmcvN0fVDSZCeLzPrJMjOBFFhlhEbxjamDtdEOyBKBC/2JNfN9ZAjLytpcx8p8qcdFpAzw6XnCbVS5xFg38+XT7Yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba-tsip.com; dmarc=pass action=none
 header.from=toshiba-tsip.com; dkim=pass header.d=toshiba-tsip.com; arc=none
From: <Sai.Sathujoda@toshiba-tsip.com>
To: <jan.kiszka@siemens.com>, <Chris.Paterson2@renesas.com>
CC: <kazuhiro3.hayashi@toshiba.co.jp>, <dinesh.kumar@toshiba-tsip.com>,
        <cip-dev@lists.cip-project.org>
Subject: QEMU reset issues in CIP LAVA worker
Thread-Topic: QEMU reset issues in CIP LAVA worker
Thread-Index: AdsCr4TnY+//JphYSB26Q1N8R60kZw==
Date: Mon, 9 Sep 2024 12:02:03 +0000
X-TSB-HOP2: ON
Message-ID: 
 <OS3PR01MB61031B36A1BE2249B2F4CA2FC2992@OS3PR01MB6103.jpnprd01.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba-tsip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS3PR01MB6103:EE_|TY3PR01MB11412:EE_
x-ms-office365-filtering-correlation-id: d60942e3-bf9a-43b5-e6a0-08dcd0c73813
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: 
 =?iso-2022-jp?B?L0d1WFJBWHlQelorTWhMZ0lyMjNrc0RYMHlpNmtNNXo2bGxDY2J2bGxj?=
 =?iso-2022-jp?B?b3Uwd2hEUi9zK2VHS1hXUjV2NzJHc25nNWRYZ0V2dHlSdFU3YTlhZUkx?=
 =?iso-2022-jp?B?ZDcyRnQrMzVvOWl6RHkwTlpKT040OGExdjdHVVB0WXpQME9RNjZvOFBo?=
 =?iso-2022-jp?B?K3N0d29ZNy9kTktMdlpVRzJGeUdXeVYzZnBLR1V5TDVpdElta2QweDN5?=
 =?iso-2022-jp?B?em93RHpXUUhqZGxCTzA4VG5iMURBZzFReEVRNFgyaUNEcER4TFl3T1gw?=
 =?iso-2022-jp?B?clFCYU1JS0hyY1F2Wk0wSzgreUdFd3BMYWM5ZVdvak0ybFZhdmlMZmhX?=
 =?iso-2022-jp?B?RysyTUptZmdzR25rTEN4eWdkOTlmSkRBNEhJU0o2MkJGcnZYeFdoQkZY?=
 =?iso-2022-jp?B?SGxGUnBpWVZqY3RKYlRPTGtlSy9VcWVUbjdPVHlvcHAvS2ptWFN2N2Za?=
 =?iso-2022-jp?B?eGxmclZ2YmNCcjNxclptYi9JZUI2SnhnZUJJeUN4NGNxQkJqa2NjdDlO?=
 =?iso-2022-jp?B?RW9heEg0Q0g2bnUzWjJOUE5ETGZIUXNKYm1xWDZKR0xReTZUanllZ2xi?=
 =?iso-2022-jp?B?eDNIQStUcUpYdHhwK09LK21HUnhBV3ZLZTdidDl0aXdpOHgycWJoeHBT?=
 =?iso-2022-jp?B?WXhyNnQ5SmlRYzM0NFBJN3dDeEtpdVd3UVNUVTNCdy91aWVzY0JaZHNT?=
 =?iso-2022-jp?B?bHdOSm1rUTBPaUxiZmxUdVM4dWxUdkNxYjVSRUtWZFIwNUN0MHd6SzNr?=
 =?iso-2022-jp?B?Uk9PcWdrdFpUTkFJRXA1SHNaWHYvZUpQL3VjU1E4OHZwVGVySGIxMzg3?=
 =?iso-2022-jp?B?dkFGS1NCVFBKamw4enY0d0ZnMHNaYkVIM212WlpBaUhlRDY4MVB6azI2?=
 =?iso-2022-jp?B?OHFJT2Vsc2lmQXBabVlsbDBlS3hKczNyaVNFdnRxOFpQcXNXSTNFOVhG?=
 =?iso-2022-jp?B?emRwNXpoYnYyZGgyLzQwRWtKc0dzelNNNm1VV3JGenlWVjR1dzBtVHNC?=
 =?iso-2022-jp?B?dW8vYmNpRkYxemRRekh3Qjh5T2x3S052SmtjdzVGNG5qMkdBdFlNRGhh?=
 =?iso-2022-jp?B?Vi9yRzZhNXh0RFFkb2R4eVBPbUtPVkVVWGVZRGQ2ci92cnp0cnY0L3h5?=
 =?iso-2022-jp?B?TjRvaldISHBYcW9iUUVqbVFRT05TQ1NYcS9Eb25BVzFHQTgwRklmQjFn?=
 =?iso-2022-jp?B?Y0puUVRtVFRkM1RJU0hsQWpiWDF6aG13bUpTS0EwQkR2aW1tM2FmbW53?=
 =?iso-2022-jp?B?TktrdVpSanVVbzJrNU9ndEVSbjdvdUQ5WHpPeC9tM0poaXdRRHY4Mlpw?=
 =?iso-2022-jp?B?cmcrZzhpU3RRbUNnQmxEVmtaeURCamJrSnp6ZkRJSm1URFJFMzFYTUpE?=
 =?iso-2022-jp?B?MXl5a1hFR2JZcVNidzZBZjY5Rkk1SHhDc3lQa1p5R0Z6MFd5eGp3UW1D?=
 =?iso-2022-jp?B?OTY3VUNQU3BtRTRSeWVyZDg5eTNTMlI0UERGaGRTU2owZndnNFoxOHJL?=
 =?iso-2022-jp?B?VHFDR3NDRURtYUN2ZzRtQjZvc0hzRGFwdmxVZDdLNjM4YjMwVEZuNFJU?=
 =?iso-2022-jp?B?Z2Y3STNjNjJCcXZpaVhBeStTQXlvYmFBdlErOWpPMFhkS0xNT2kvWkUx?=
 =?iso-2022-jp?B?MWtQMllJNnBmdkhvZ1ZPdUhzOTFXYThna1l5SU5SUlN4WnBDSytzaU1V?=
 =?iso-2022-jp?B?aDFLRk5lVEFLOGpFbFhWbjhSUklEODB4SUJMMW0zd2RsOXE2b0E0eFBR?=
 =?iso-2022-jp?B?bktWVjRuQlZDdnNyREJzaEMvYUxOS0tRNTdGdXZDTEVhdTBsUnNPdlZN?=
 =?iso-2022-jp?B?NndySDdlN3YwbUhocnh6cnhFc3VwZFd0aGRGWldJR3E0dmdjanB0eGFC?=
 =?iso-2022-jp?B?V1hsd1pidFBVdDlmK1dWNmtqY0JYTGNLZE1jRzB2c2tLaUdNNUZ0eUpT?=
 =?iso-2022-jp?B?V2lRZnMxVGV0eXlZc3ZUUDlld3NaUkNRTTQrcW9PYmFBTXR1OHN2dEpB?=
 =?iso-2022-jp?B?S0wzQWtpYjBnNGxOcldvbklZcUtqNmtodEtTUVFLVEo3eHJ1aXlna0xV?=
 =?iso-2022-jp?B?bnc9PQ==?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS3PR01MB6103.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?TGdhKzU1SnlEcDJVamFDTUhKYjQrVmZWUzYvcjljTTIzRmVXVVpKeTJX?=
 =?iso-2022-jp?B?TzBMTEZGaldiS21ZYTZVbTRtVlJWTDlScGRrRENNMUNJV3VXK1NqOGpn?=
 =?iso-2022-jp?B?d2t4a1lKem9JNURpb1lkczdQeGEwbTJpekdWWGhrYUlHOFJ6VGl6TVh4?=
 =?iso-2022-jp?B?ZERydEZ2K1R4RDVHZzhuZ3JWZG9rb3hPcmxyZHRqVVRuNDk5ZFdBMEl0?=
 =?iso-2022-jp?B?WmptdDU5UktVWGVwQ2NaeDFzM09ZWFQzdDUzQWpVSVlDNnYvQzh2OWZu?=
 =?iso-2022-jp?B?UTUzMFNPT1VOTjQ0aDIzVVovMSt1cjNOWVFWVXlMMndqR1BjTGpvck05?=
 =?iso-2022-jp?B?UGJ6QjF0N05heXFleStGbUtaQTFCeUNCdkxoaGcrYURwWnBLWUtUTG85?=
 =?iso-2022-jp?B?bzZBcE81MC91bWpsbnlkYXpmZzdKMUpieitTVUhEREUzNHdCRjBmZWlF?=
 =?iso-2022-jp?B?eHdTeXJPVStKUW90OHFXb2o2bkREbTVIc2R1ZWNJeVNaWkwzV1B4ZlpS?=
 =?iso-2022-jp?B?TnAzeE84V3d3RVhEcmFJNVBrTmk3MllKZGlzbjBSL1BVTVZMNGd6YU1T?=
 =?iso-2022-jp?B?Zm02Q0pIaWJ3VTZ2SWZUVmpuUnZCV2d2S2dlUkxuWFIrVzV1VXN3NGdw?=
 =?iso-2022-jp?B?WWRwOHA5T0V0azJrRGZmNTVWNUZ0K3UrVXZhODlaeTNIRnVLUWZoanJT?=
 =?iso-2022-jp?B?Nzgwb0tRYkZ1enB3WWpuVUJlS0FjNWcwUHpMUGxQenFFTXZuYllZWURx?=
 =?iso-2022-jp?B?WjlyV0tiQXRLN04ya29zaGVEazdIVnBYMDdvU2NyYllmZlV3VTlOUVQ5?=
 =?iso-2022-jp?B?LzlNYkNEbEI4UjhaZ1ZBbW02blFlYVhiTG5QcHlMLytQZFg0VzFpTjI2?=
 =?iso-2022-jp?B?SkhoTkxRWStLdlBCOUJKYitDSm1LOCtkR09HOGM0NFhrUWxOWTF2UzNW?=
 =?iso-2022-jp?B?dG14SjNqZnJ3a1dFSGlkdHdXdFBTaEQyYzBOU2dacGNOSjhuMDFmQ25W?=
 =?iso-2022-jp?B?VVlqZ3lJM0VhcStUbVZKWml2di83SGZEMnJ1THZ2NHFMd1RPOHo4Yncv?=
 =?iso-2022-jp?B?cFE5bXBGUVpKaEt0WTFmV3RiemxGTjRlcDhVUkRoclRKbWlSRzJuajlE?=
 =?iso-2022-jp?B?MFptZXE4c0lvVHRsdzF2eXNtc1FYU3N1U0hsUDVTVWtIS0k5amV4RTlz?=
 =?iso-2022-jp?B?L2FINnR5WnVBRTlpbW1xTUx5QzhOVnBIOGYrZXo2WFR4dzl2czNIb21S?=
 =?iso-2022-jp?B?bVZ5OHl5UEgvdVJNbHlzNDNQaVZJZ2d3QThHZWdTU3IvZ2lycUFuK3FS?=
 =?iso-2022-jp?B?WlZjN3grdWIwSks0TnY0d0tuL0R6RExLRTQ4M09MTVM2ZTQrR1dLMTBv?=
 =?iso-2022-jp?B?dFBxTk5VSjhMdG1lUVdiMlJzRFdNWS9wYXJadk81QmhqU0VrZXlNdmJp?=
 =?iso-2022-jp?B?cVlicmFwd3QrdWFOZEZhUGpDOXkxWWJlRUpncFdKblFsNFRSMS9jcXd1?=
 =?iso-2022-jp?B?NnJFMEliQVFWOFVlRms4cEVMMWhEZjBod3RDQW9Vd29UaDZpVlRCOGpo?=
 =?iso-2022-jp?B?YTlQQ1V1eGdSRlFGOGFhMGh2Z3d2bEphTjVXcmNOU1k0QUd1QW9tb1B0?=
 =?iso-2022-jp?B?OWNSV2k0dHBqZ0JHa0krOWlIN1pLblpIcUNaNitLdG1wcXV1UWRhZnVW?=
 =?iso-2022-jp?B?UkIzWktFUHBDeHE0Y0gwMVpJa3J2U0p6dkF0QlFTdmpmbWxaOW5TQ0ZN?=
 =?iso-2022-jp?B?eEw1S0dSKzBySWNvbVdxeUhuYVhyMDcxT2ZjQVpwWUlJNGRoTEdPWTk5?=
 =?iso-2022-jp?B?UGNySzV5SUU0ZFlHcVZYK05EOHdQaVF2ODVxNlBzSVZYeXIzM1NEeFdX?=
 =?iso-2022-jp?B?V3JjcWVaZW9nOHpRWkpBQmoxTm5LTGp0V09uM0xWbXpPMk5Tbnpuc3Fl?=
 =?iso-2022-jp?B?N1BOWi9Ua2c4Z3JvSXRCZHQwK3VhRUsrUnkzZkM2WlNyWnIvZVlyMEp3?=
 =?iso-2022-jp?B?TDR2bHUyZkcrMTdoVjh2Q2N3T2NmcmI0Ull0U2VSOWJ4TGNWei9nNlBr?=
 =?iso-2022-jp?B?Ump0Tlc3TjNKU0MrZDcxVjVzQVNmQkVjcjBhWFZ4L1RMR1VVM1dCRzg1?=
 =?iso-2022-jp?B?UnpKeVNJVmRvY3NnV29MV2lwSENDMWgvUjBLZkVEaFVydlRjK1U3NUVE?=
 =?iso-2022-jp?B?dHBMLytIMUsvUE15QnVGQ1N1T1hpdUVwaWpiZ0ljNmZCUjM4K2lTZ0gv?=
 =?iso-2022-jp?B?dlpPOXI5T0JlVnk2ejdHMS9KTXYwcHFBZ1NBS2JzQUM1Sm5mTkJLLzNy?=
 =?iso-2022-jp?B?RStKSkM0K0IvYklRTEM1VkVONFg4OEtZVXoyTVVLa1VBV1JjbmNCL0pm?=
 =?iso-2022-jp?B?c1ZSRVkvUitIUlhURDVmTnkxeFdjVG1jb0x5M1BiRnNob2twNnFmakNS?=
 =?iso-2022-jp?B?aWJpL0VRPT0=?=
Content-Type: multipart/mixed;
	boundary="_004_OS3PR01MB61031B36A1BE2249B2F4CA2FC2992OS3PR01MB6103jpnp_"
MIME-Version: 1.0
X-OriginatorOrg: toshiba-tsip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS3PR01MB6103.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d60942e3-bf9a-43b5-e6a0-08dcd0c73813
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Sep 2024 12:02:03.7642
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: z7E6RaonD8H7ffiEtivAA36/Y6rK+6VEdTHcm1wysQxXj7ACFrKpqgNd4c/cBGBKS9Bol9mYKEJAM4+tEBGinUaAaTKDtzn5XbC57ADKn8c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3PR01MB11412
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 09 Sep 2024 12:02:13 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16875

--_004_OS3PR01MB61031B36A1BE2249B2F4CA2FC2992OS3PR01MB6103jpnp_
Content-Type: multipart/alternative;
	boundary="_000_OS3PR01MB61031B36A1BE2249B2F4CA2FC2992OS3PR01MB6103jpnp_"

--_000_OS3PR01MB61031B36A1BE2249B2F4CA2FC2992OS3PR01MB6103jpnp_
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable

Hello Jan and Chris,

I have taken a list of all the failed jobs in LAVA after enabling secure bo=
ot, software update and IEC testing in isar-cip-core. The inconsistent rese=
t issues during boot and getting stuck during encryption of /home and /var =
are found only in lab-cip-siemens-muc.

Currently I have no idea what the problem in that worker might be. I think =
until we know the reason for this behavior in lab-cip-siemens-muc, maybe we=
 can remove =1B$B!F=1B(Bswtpm-jobs=1B$B!G=1B(B tag from QEMU device in that=
 worker to avoid failures for now and parallelly debug the problem.

Note: The failures in other workers provided in the attached sheet are know=
n errors.

Thanks and regards,
Sai Ashrith Sathujoda (T S I P)

--_000_OS3PR01MB61031B36A1BE2249B2F4CA2FC2992OS3PR01MB6103jpnp_
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
	{font-family:Helvetica;
	panose-1:2 11 6 4 2 2 2 2 2 4;}
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;
	mso-ligatures:standardcontextual;}
span.EmailStyle17
	{mso-style-type:personal-compose;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;}
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
<body lang=3D"EN-US" link=3D"#0563C1" vlink=3D"#954F72" style=3D"word-wrap:=
break-word">
<div class=3D"WordSection1">
<p class=3D"MsoNormal">Hello Jan and Chris,<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">I have taken a list of all the failed jobs in LAVA a=
fter enabling secure boot, software update and IEC testing in isar-cip-core=
. The inconsistent reset issues during boot and getting stuck during encryp=
tion of /home and /var are found only
 in <b><span style=3D"font-size:10.5pt;font-family:&quot;Helvetica&quot;,sa=
ns-serif;color:#333333;background:white">lab-cip-siemens-muc</span></b><spa=
n style=3D"font-size:10.5pt;font-family:&quot;Helvetica&quot;,sans-serif;co=
lor:#333333;background:white">.</span><o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Currently I have no idea what the problem in that wo=
rker might be. I think until we know the reason for this behavior in
<span style=3D"font-size:10.5pt;font-family:&quot;Helvetica&quot;,sans-seri=
f;color:#333333;background:white">
lab-cip-siemens-muc</span>, maybe we can remove =1B$B!F=1B(Bswtpm-jobs=1B$B=
!G=1B(B tag from QEMU device in that worker to avoid failures for now and p=
arallelly debug the problem.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Note: The failures in other workers provided in the =
attached sheet are known errors.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Thanks and regards,<o:p></o:p></p>
<p class=3D"MsoNormal">Sai Ashrith Sathujoda (T S I P)<o:p></o:p></p>
</div>
</body>
</html>

--_000_OS3PR01MB61031B36A1BE2249B2F4CA2FC2992OS3PR01MB6103jpnp_--

--_004_OS3PR01MB61031B36A1BE2249B2F4CA2FC2992OS3PR01MB6103jpnp_
Content-Type: text/plain; name="all_failed_lava_jobs.txt"
Content-Description: all_failed_lava_jobs.txt
Content-Disposition: attachment; filename="all_failed_lava_jobs.txt";
	size=3613; creation-date="Mon, 02 Sep 2024 18:53:32 GMT";
	modification-date="Mon, 09 Sep 2024 12:02:02 GMT"
Content-Transfer-Encoding: base64

RGV2aWNlOiBxZW11LTAzDQoNCmh0dHBzOi8vbGF2YS5jaXBsYXRmb3JtLm9yZy9zY2hlZHVsZXIv
am9iLzExNzkwNDcNCmh0dHBzOi8vbGF2YS5jaXBsYXRmb3JtLm9yZy9zY2hlZHVsZXIvam9iLzEx
NzgyNjENCmh0dHBzOi8vbGF2YS5jaXBsYXRmb3JtLm9yZy9zY2hlZHVsZXIvam9iLzExNzgyNDcN
Cmh0dHBzOi8vbGF2YS5jaXBsYXRmb3JtLm9yZy9zY2hlZHVsZXIvam9iLzExNzgwODgNCg0KLS0t
LS0tDQoNCkRldmljZTogcWVtdS1jaXAtc2llbWVucy1tdWMNCg0KaHR0cHM6Ly9sYXZhLmNpcGxh
dGZvcm0ub3JnL3NjaGVkdWxlci9qb2IvMTE4MTk1Mg0KaHR0cHM6Ly9sYXZhLmNpcGxhdGZvcm0u
b3JnL3NjaGVkdWxlci9qb2IvMTE4MTk0NA0KaHR0cHM6Ly9sYXZhLmNpcGxhdGZvcm0ub3JnL3Nj
aGVkdWxlci9qb2IvMTE4MDMxOA0KaHR0cHM6Ly9sYXZhLmNpcGxhdGZvcm0ub3JnL3NjaGVkdWxl
ci9qb2IvMTE4MDMxMw0KaHR0cHM6Ly9sYXZhLmNpcGxhdGZvcm0ub3JnL3NjaGVkdWxlci9qb2Iv
MTE4MDI2Nw0KaHR0cHM6Ly9sYXZhLmNpcGxhdGZvcm0ub3JnL3NjaGVkdWxlci9qb2IvMTE4MDAx
MA0KaHR0cHM6Ly9sYXZhLmNpcGxhdGZvcm0ub3JnL3NjaGVkdWxlci9qb2IvMTE4MDAwMg0KaHR0
cHM6Ly9sYXZhLmNpcGxhdGZvcm0ub3JnL3NjaGVkdWxlci9qb2IvMTE3OTA1Nw0KaHR0cHM6Ly9s
YXZhLmNpcGxhdGZvcm0ub3JnL3NjaGVkdWxlci9qb2IvMTE3OTA0OQ0KaHR0cHM6Ly9sYXZhLmNp
cGxhdGZvcm0ub3JnL3NjaGVkdWxlci9qb2IvMTE3ODA5Nw0KaHR0cHM6Ly9sYXZhLmNpcGxhdGZv
cm0ub3JnL3NjaGVkdWxlci9qb2IvMTE3ODA5MA0KaHR0cHM6Ly9sYXZhLmNpcGxhdGZvcm0ub3Jn
L3NjaGVkdWxlci9qb2IvMTE2ODg4NA0KaHR0cHM6Ly9sYXZhLmNpcGxhdGZvcm0ub3JnL3NjaGVk
dWxlci9qb2IvMTE2ODg2MQ0KaHR0cHM6Ly9sYXZhLmNpcGxhdGZvcm0ub3JnL3NjaGVkdWxlci9q
b2IvMTE2NjY0Mw0KaHR0cHM6Ly9sYXZhLmNpcGxhdGZvcm0ub3JnL3NjaGVkdWxlci9qb2IvMTE2
NjYzMA0KaHR0cHM6Ly9sYXZhLmNpcGxhdGZvcm0ub3JnL3NjaGVkdWxlci9qb2IvMTE2NjU5NA0K
aHR0cHM6Ly9sYXZhLmNpcGxhdGZvcm0ub3JnL3NjaGVkdWxlci9qb2IvMTE2NDQxMw0KaHR0cHM6
Ly9sYXZhLmNpcGxhdGZvcm0ub3JnL3NjaGVkdWxlci9qb2IvMTE2NDQwMQ0KaHR0cHM6Ly9sYXZh
LmNpcGxhdGZvcm0ub3JnL3NjaGVkdWxlci9qb2IvMTE2MTY2NA0KaHR0cHM6Ly9sYXZhLmNpcGxh
dGZvcm0ub3JnL3NjaGVkdWxlci9qb2IvMTE2MTY1NA0KaHR0cHM6Ly9sYXZhLmNpcGxhdGZvcm0u
b3JnL3NjaGVkdWxlci9qb2IvMTE2MTYxMQ0KaHR0cHM6Ly9sYXZhLmNpcGxhdGZvcm0ub3JnL3Nj
aGVkdWxlci9qb2IvMTE2MTYwNQ0KDQotLS0tLS0NCg0KRGV2aWNlOiBxZW11LXBhdGVyc29uYy0w
MQ0KDQpodHRwczovL2xhdmEuY2lwbGF0Zm9ybS5vcmcvc2NoZWR1bGVyL2pvYi8xMTgxOTQ3DQpo
dHRwczovL2xhdmEuY2lwbGF0Zm9ybS5vcmcvc2NoZWR1bGVyL2pvYi8xMTgwMjc1DQpodHRwczov
L2xhdmEuY2lwbGF0Zm9ybS5vcmcvc2NoZWR1bGVyL2pvYi8xMTgwMjcwDQpodHRwczovL2xhdmEu
Y2lwbGF0Zm9ybS5vcmcvc2NoZWR1bGVyL2pvYi8xMTgwMjY4DQpodHRwczovL2xhdmEuY2lwbGF0
Zm9ybS5vcmcvc2NoZWR1bGVyL2pvYi8xMTgwMDA3DQpodHRwczovL2xhdmEuY2lwbGF0Zm9ybS5v
cmcvc2NoZWR1bGVyL2pvYi8xMTgwMDAzDQpodHRwczovL2xhdmEuY2lwbGF0Zm9ybS5vcmcvc2No
ZWR1bGVyL2pvYi8xMTc5MjM3DQpodHRwczovL2xhdmEuY2lwbGF0Zm9ybS5vcmcvc2NoZWR1bGVy
L2pvYi8xMTc5MDU2DQpodHRwczovL2xhdmEuY2lwbGF0Zm9ybS5vcmcvc2NoZWR1bGVyL2pvYi8x
MTc5MDQ2DQpodHRwczovL2xhdmEuY2lwbGF0Zm9ybS5vcmcvc2NoZWR1bGVyL2pvYi8xMTc4Mjc4
DQpodHRwczovL2xhdmEuY2lwbGF0Zm9ybS5vcmcvc2NoZWR1bGVyL2pvYi8xMTc4MjEwDQpodHRw
czovL2xhdmEuY2lwbGF0Zm9ybS5vcmcvc2NoZWR1bGVyL2pvYi8xMTc4MDkzDQpodHRwczovL2xh
dmEuY2lwbGF0Zm9ybS5vcmcvc2NoZWR1bGVyL2pvYi8xMTQzNzE5DQpodHRwczovL2xhdmEuY2lw
bGF0Zm9ybS5vcmcvc2NoZWR1bGVyL2pvYi8xMTQzNzE4DQpodHRwczovL2xhdmEuY2lwbGF0Zm9y
bS5vcmcvc2NoZWR1bGVyL2pvYi8xMTQzMjkzDQpodHRwczovL2xhdmEuY2lwbGF0Zm9ybS5vcmcv
c2NoZWR1bGVyL2pvYi8xMTQzMjkwDQpodHRwczovL2xhdmEuY2lwbGF0Zm9ybS5vcmcvc2NoZWR1
bGVyL2pvYi8xMTQzMjg3DQpodHRwczovL2xhdmEuY2lwbGF0Zm9ybS5vcmcvc2NoZWR1bGVyL2pv
Yi8xMTQzMjg1DQpodHRwczovL2xhdmEuY2lwbGF0Zm9ybS5vcmcvc2NoZWR1bGVyL2pvYi8xMTM5
NzkzDQpodHRwczovL2xhdmEuY2lwbGF0Zm9ybS5vcmcvc2NoZWR1bGVyL2pvYi8xMTM3NzQ5DQpo
dHRwczovL2xhdmEuY2lwbGF0Zm9ybS5vcmcvc2NoZWR1bGVyL2pvYi8xMTM3NzQ3DQpodHRwczov
L2xhdmEuY2lwbGF0Zm9ybS5vcmcvc2NoZWR1bGVyL2pvYi8xMTM3NzQzDQpodHRwczovL2xhdmEu
Y2lwbGF0Zm9ybS5vcmcvc2NoZWR1bGVyL2pvYi8xMTM3NzQyDQpodHRwczovL2xhdmEuY2lwbGF0
Zm9ybS5vcmcvc2NoZWR1bGVyL2pvYi8xMTM3NDU2DQpodHRwczovL2xhdmEuY2lwbGF0Zm9ybS5v
cmcvc2NoZWR1bGVyL2pvYi8xMTM3NDU0DQpodHRwczovL2xhdmEuY2lwbGF0Zm9ybS5vcmcvc2No
ZWR1bGVyL2pvYi8xMTM3NDUxDQpodHRwczovL2xhdmEuY2lwbGF0Zm9ybS5vcmcvc2NoZWR1bGVy
L2pvYi8xMTM3MzgwDQoNCi0tLS0tLS0tLS0NCg0KRGV2aWNlOiBxZW11LXJlbmVzYXMtMDENCg0K
aHR0cHM6Ly9sYXZhLmNpcGxhdGZvcm0ub3JnL3NjaGVkdWxlci9qb2IvMTE4MDAwOQ0KaHR0cHM6
Ly9sYXZhLmNpcGxhdGZvcm0ub3JnL3NjaGVkdWxlci9qb2IvMTE2ODg2Mg0KaHR0cHM6Ly9sYXZh
LmNpcGxhdGZvcm0ub3JnL3NjaGVkdWxlci9qb2IvMTE1MTgyOA0KaHR0cHM6Ly9sYXZhLmNpcGxh
dGZvcm0ub3JnL3NjaGVkdWxlci9qb2IvMTE1MTI1NA0KaHR0cHM6Ly9sYXZhLmNpcGxhdGZvcm0u
b3JnL3NjaGVkdWxlci9qb2IvMTE0OTQ1Ng0KaHR0cHM6Ly9sYXZhLmNpcGxhdGZvcm0ub3JnL3Nj
aGVkdWxlci9qb2IvMTE0MzcxNg0KaHR0cHM6Ly9sYXZhLmNpcGxhdGZvcm0ub3JnL3NjaGVkdWxl
ci9qb2IvMTE0MzcxNQ0KaHR0cHM6Ly9sYXZhLmNpcGxhdGZvcm0ub3JnL3NjaGVkdWxlci9qb2Iv
MTE0MzUzNQ0KaHR0cHM6Ly9sYXZhLmNpcGxhdGZvcm0ub3JnL3NjaGVkdWxlci9qb2IvMTE0MzMx
Ng0KaHR0cHM6Ly9sYXZhLmNpcGxhdGZvcm0ub3JnL3NjaGVkdWxlci9qb2IvMTE0MzI5Mg0KaHR0
cHM6Ly9sYXZhLmNpcGxhdGZvcm0ub3JnL3NjaGVkdWxlci9qb2IvMTE0MzI4OQ0KaHR0cHM6Ly9s
YXZhLmNpcGxhdGZvcm0ub3JnL3NjaGVkdWxlci9qb2IvMTE0MzI4NA0KaHR0cHM6Ly9sYXZhLmNp
cGxhdGZvcm0ub3JnL3NjaGVkdWxlci9qb2IvMTEzOTc5NA0KaHR0cHM6Ly9sYXZhLmNpcGxhdGZv
cm0ub3JnL3NjaGVkdWxlci9qb2IvMTEzOTQ0NA0KaHR0cHM6Ly9sYXZhLmNpcGxhdGZvcm0ub3Jn
L3NjaGVkdWxlci9qb2IvMTEzOTQ0Mg==

--_004_OS3PR01MB61031B36A1BE2249B2F4CA2FC2992OS3PR01MB6103jpnp_--


