Return-Path: <sai.sathujoda@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E04DDC83F16
	for <webhook@archiver.kernel.org>; Thu, 29 Aug 2024 12:54:04 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.134])
 by mx.groups.io with SMTP id smtpd.web11.13474.1724936035059449083
 for <cip-dev@lists.cip-project.org>;
 Thu, 29 Aug 2024 05:53:55 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.134, mailfrom: sai.sathujoda@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1800) id 47TCrqSd3090968; Thu, 29 Aug 2024 21:53:53 +0900
X-Iguazu-Qid: 2yAapsDzDOf3kvsL1E
X-Iguazu-QSIG: v=2; s=0; t=1724936032; q=2yAapsDzDOf3kvsL1E; m=S/R4/pXz5CqMFd/2OvlZP69YAAx5j7fDTTqRGZfTDVk=
Received: from imx12-a.toshiba.co.jp ([38.106.60.135])
	by relay.securemx.jp (mx-mr1801) id 47TCrpUc1113476
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 29 Aug 2024 21:53:51 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QnKfwAM6MvBK7aXHFgnvVN1PuZ6upnmXscYh9zJTLEhJiZL5u78vnXry5DchvWY/ICI5TFcqTH3ljXz1sssfnqfFtu5t8svLcD33Iy8ttmfa2PCXbu4WTPJz3nxZEevHa1iy6XqdZT64xBw1besxXxlW/VO0eanhkjQwvjf4psCemk8brNiGnaP9gKLBFcPh/UwXn0Me9ZGNFtHAcUBI18wftX8I1PMy8r0oCfm1E62+k6+OtIUS1w23Nr79Jkj+ODR4gNtdlTfpbX8IIZxrxp3fgenm/+/sF8QQ9Dmm9A9KYn+5X5sNKL8vA4MSEKg0nVwxy4xUokGNurMQwJFMQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zoHmnAiCBaGCS9fUEwNyW0/gNBlS5gM6Icve+Qafqss=;
 b=FpurjE8Pire3mdtFJDMiX9bYBgroFr1y9YGu50cX4piQWB07GDjhgKf8oAUY6KVFxANN2TENZeHG+/afeOrAYheipEKeOwAFSutqSTzKVgvSRglNugUNXJMUD9+WyCkHjZh7eulLy6LuZ2Mb2Kc3Bw86u2PPya1maiVh4dLeQvy6vualLXI7AAdBx5ZcO/8M3OT2ufd+Ws6fXQEPE4CofSF7+Q8ZLcfHzHvOejop7ihMf0HIZSvAH5JRG3rPlBrum537uBH+4nCesRU7YgHeI/IXdA4Hdh2b/F8U1YwyFn7DL78MfNV0m3IeZYxpvNKLyj3iQGoO3zIrc44YnIFsIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba-tsip.com; dmarc=pass action=none
 header.from=toshiba-tsip.com; dkim=pass header.d=toshiba-tsip.com; arc=none
From: <Sai.Sathujoda@toshiba-tsip.com>
To: <Chris.Paterson2@renesas.com>
CC: <cip-dev@lists.cip-project.org>, <kazuhiro3.hayashi@toshiba.co.jp>,
        <dinesh.kumar@toshiba-tsip.com>
Subject: Issue with 'small' Gitlab runners
Thread-Topic: Issue with 'small' Gitlab runners
Thread-Index: Adr6EQ3RL8rQAtQSSy+tF4/i30H+FA==
Date: Thu, 29 Aug 2024 12:53:48 +0000
X-TSB-HOP2: ON
Message-ID: 
 <OS3PR01MB6103DA72FFDEBC407A5900A6C2962@OS3PR01MB6103.jpnprd01.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba-tsip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS3PR01MB6103:EE_|TYWPR01MB10307:EE_
x-ms-office365-filtering-correlation-id: afb53eed-a5f5-4fba-0cf1-08dcc829a03e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: 
 =?iso-2022-jp?B?NWoxdHdQVk9IdG54bTlFVmNhUlh2dkUweUhpM2ZWK2M0WDhucmtpaita?=
 =?iso-2022-jp?B?NFBnNnIzMVVxcW1vRkUyR0orNXMvUjFGYmpzeS9FQ0tvNzFMeHFTV2lt?=
 =?iso-2022-jp?B?VllWS2pmN2pFZTJFSHNzRFp1Q2Q4dVc5NEQ3eEdubGdSbHBOVlNCSTlm?=
 =?iso-2022-jp?B?dlA3TnRCTG5DNnRPbnlaS2oxN1Myam53RmZUeXFPMEhqWHJvOFJMV0c4?=
 =?iso-2022-jp?B?N3ExL0lHZGViREJlckV0MTVtREdNM1VNeFdFN0o1VWVrY1huNStWWmlv?=
 =?iso-2022-jp?B?NHM3SDd5VVhmR1h4TGFkR2hqc0dBQ3dtU1lNVWloWFhRMWgwcVBIbkVz?=
 =?iso-2022-jp?B?dXNMNUUwSkRqT0tRR0NSTnlKT0diWG5Wa1dEMTdvR294QkNucHVYQXFE?=
 =?iso-2022-jp?B?Ums5N0JNSXFZeHhiczdsOHlHSFN5MVRoajhjTmwrSDlrQmVkdThWVGYz?=
 =?iso-2022-jp?B?NnV1L0VRcWJnb01QWlpRNUZOKzlvamR4aVVoSnI3TFFrMldWcFBveURw?=
 =?iso-2022-jp?B?dUN0T1RVNEVBMGVKSU5MRDhNaDE3czU5OWJRZEZ3aGRPcjVQVndZSGds?=
 =?iso-2022-jp?B?Wk1reC9tODlkUWZXNXk5eUlqRzJuMXdSN2dHZ1pYU2hHTGJsRkNQN0h3?=
 =?iso-2022-jp?B?dkRKWDllclJuR293THh4L1VkWUIwN3RWc3c1bXI4blhBcUNFRS9RaUhi?=
 =?iso-2022-jp?B?SHhVVTZzaDRVMk82ZnlBa1lKVExoLzFPVmF5YVFrOHkrTTdNUkZycVJQ?=
 =?iso-2022-jp?B?NU5VN0lqckNNRFhUZEkzOFlucmtITjBBUXBCUkRJMVlVMGpRZ3ZZZkRS?=
 =?iso-2022-jp?B?SlEwU0p0OHVpQTBzYWRBYlhGOFVvbFltRzFSemtYaWRXYVNyMGV2WnJD?=
 =?iso-2022-jp?B?eHlVMnZheEpKLzZzZndyS2ZzbHFpcFJUb0lLcmM0RHB6QWJVVzVRd3hj?=
 =?iso-2022-jp?B?bWxua1dzNVBYeHRxZ2RNWG1VcnA1LzRsR3dBd1duYmFCdWhGcURCbGZw?=
 =?iso-2022-jp?B?blgzbmlXZExjQVJJb0wrVUxETDRPcDJIR0JTbUxnWUlyVWhUUXVrODcr?=
 =?iso-2022-jp?B?ak45aVhFTU9hSUl5Tk1aeFd4RVF6VVFacGxwNTY1QVZoK3Y4b0JJS294?=
 =?iso-2022-jp?B?bEg2UDd5ZXNMV1h5SUl4SjJhSm8zaEFndEx0cm5GeUhVY0pnTW8wbVFx?=
 =?iso-2022-jp?B?VGJDbzVqRUc4S3NEM0JhOVpqd0hidHM2NnQxQUwzNm0wWW5VWnVrRXRV?=
 =?iso-2022-jp?B?VHRMN2haN3ppaG13MS9hZlFocHhBK0xqMEwvR21sNUdRSk5CcTV6eGhH?=
 =?iso-2022-jp?B?b2llTDBSRDRWS1pJbWhRbGtpRFRFeitIVnBUUjlXancyNVg3cENNU2Zh?=
 =?iso-2022-jp?B?azhIZmhhMmNqSkIzOTBBZWxjTkpxQXVnKzFKL0xQTzJYZ2E1akRrMERQ?=
 =?iso-2022-jp?B?aXJzOUNOK2Y2UWthK0V6TitYbDRiTnliUWhLb09PQ3RyWUxicGdoMm1I?=
 =?iso-2022-jp?B?UlhTeWdQVGRUNlU4UmZRbGFCZWlVclZRaHJWNklPa2N1KzB5ejZCLzM5?=
 =?iso-2022-jp?B?VHA5YkNUQ0ZQeC80VEVLNmtueFhCSVZpakNkUTRuYml5ZXBBRTd4VmhX?=
 =?iso-2022-jp?B?U3Y0RW1qUyt0Y2x1VmdlT3JIeWNjMHdsUU1KK0pDaXBFM2g3U3I5Y3g1?=
 =?iso-2022-jp?B?RlkwRFY1NmhXNTU5QS9NU0k4eEs2YllYbzZMbWdCMjlwL0tvU3FDMERZ?=
 =?iso-2022-jp?B?YnBIYm4wWmprcEdGTnZYalFaVnlXcS9ydzNtQ29IYU94Q2RORXlySUhW?=
 =?iso-2022-jp?B?bGw2WmtTTkhSU1JjbnQxNmdGMkwyTFBDVkFxblF6bmlGZUlBN2hhY0Zs?=
 =?iso-2022-jp?B?cXdPb0Z2UTdnRVhzUUtDcU4xL0N1cTlDbUxMR2VpWS9JK0VZZytnVy9q?=
 =?iso-2022-jp?B?T2M5ZGkrY2Z4Y3BhcE5HcTFja1hzTnpuSndWNzMrSzg0M01WQXZJYlB5?=
 =?iso-2022-jp?B?Rzd2TmVFY2x4SFNxSmpTSktYblQxVE9ERmxHTTBMTnQ2UVpwY3czeDFp?=
 =?iso-2022-jp?B?Vnc9PQ==?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS3PR01MB6103.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?L0twN1BvOXUwdkZVV3ErTG1XQWdBVjBqS3NoVnd1SWlqQVpPdzVBclBE?=
 =?iso-2022-jp?B?eFJudHVQSkpjZ1VmbXhDeXZ1elliWEI0LzVCSTJyV1ZNdjlxZXdSTXB1?=
 =?iso-2022-jp?B?dExhbGdBZHlpb2JzVW15bk1IVVR5ZlFVYkVGSS9qaVRHeWtmdzdhdFFm?=
 =?iso-2022-jp?B?c1J0NENMZmpJZVBxcDE5cVJVamY5YVBWMTVRbGFjTzZSNEJVeDM1RGlT?=
 =?iso-2022-jp?B?WEJkd2dXeFQ0TlJabmVNUGJOcVdWRk05aEZsWitoNXBEdWNYNFprRjFV?=
 =?iso-2022-jp?B?aVpFRE9XZ0F6cFdMdm9zSjhWUFNSYzdlcTlZRnd6ZGFGSUplVGVIK25j?=
 =?iso-2022-jp?B?cU8wdXpHYklhOTVCQnZOMDJwYW0rSmtZVVlyb0JoZU5BWUI0TWdrM0Ry?=
 =?iso-2022-jp?B?cWZiYWtnZFA3L01hSzJoaEhnVTIxbDdzaXEyMnVtRXdRb3dmZ25uWjBU?=
 =?iso-2022-jp?B?VXhrZ2xNb3drSzdZTWIySDdDQ0lkaGgxUUcwMFBtamc4d2ljOUw5NmE1?=
 =?iso-2022-jp?B?cy95Ui9BMFlyNzN6cU50bm9WQmRrVS9uZWNSRFlCUEFZeGxobUlaU1FE?=
 =?iso-2022-jp?B?L2JoWTYyRUhTdURmRGZIVVhlWWc4SkFMK2dwTkpVMjBQeG4rNUhmMmJT?=
 =?iso-2022-jp?B?Mkt6bHNMRzlOd2ZEVmU3TTc0aGE0dGU2eGVJVnJPZWtyNFFmTzVDblBS?=
 =?iso-2022-jp?B?YVUzTElDM0hMNUdFcFpmVmU0Z1d1bzFYRkpiMHZNZ2lBeSs5ZVY5SlN3?=
 =?iso-2022-jp?B?RTJpcDRQRWYxOVc4M0FOZWY4YTNGdzZndlRiNXFmSFlldHJkTHpWWFY3?=
 =?iso-2022-jp?B?TTU2SDlkNW0yWlZ3a1RjMUJGUkQvMlFMS1hMYlFlYVYwbWljL0JEcy80?=
 =?iso-2022-jp?B?V0c1MlBSWk15TGcvK2tjaXpqdmYvTmRUb2dEVWYzMkI5SHNaRFhzcmhU?=
 =?iso-2022-jp?B?REdMTzNUalFoK25sejNyKzVsa0hzRzFzdlVxMUZBQjdaOStFNlQ4UGlt?=
 =?iso-2022-jp?B?Q0FPME5scmdWREcwVEhyN2s4Y21iemNaWUJLMitzWjVCc0wrUCt6Vnhh?=
 =?iso-2022-jp?B?YXlrQUdUKzhPVEUwN1ZoK3BIRlZHelIwdldFS2JKdWVtVnRaMlhRNlJ0?=
 =?iso-2022-jp?B?ekhLSXBqZXYxUkNYeVNvUDc0ZG9yV2t5bWprZ3M0MlVLTkN4Y2hHelIx?=
 =?iso-2022-jp?B?TkFxYzMycitZRllISTFYa2FCRCtvLzRySFVGM281NjNkZmhROURGRUVS?=
 =?iso-2022-jp?B?NmdNa0FhR0owK0RLdEhVVXhyWjlxTlVkTzlzdTFYeVFxc0lBVVdnTTk3?=
 =?iso-2022-jp?B?TUkvdVF6TmdYRS9SNXY1NFY5aGVXZ09rYlRlekVrY09GK0FPTkNtQTVK?=
 =?iso-2022-jp?B?aXEzKytGUXhJbE56WG1RdjQ3V1VYOUY1YlhBbXJNWURDWEVhVGhsZHZq?=
 =?iso-2022-jp?B?TDJQMUJQR01jeGtzRG9mb3BBdFJ1MnFhdWNTdVNVY2pHVzlDYlRCOWEr?=
 =?iso-2022-jp?B?ekMzWktQMEZrZHdqb2FzelAxRnE1dUxpY1o5VmxIRjRCSzhaRWZJOUli?=
 =?iso-2022-jp?B?bi90WDQrN3d4NW1YNkxJZ3FtYk0xNWZCRTZXeEtiWkw4RStLM1Uxb0pL?=
 =?iso-2022-jp?B?UVJoSStQRWFSdGVDQUpUR2gxOEtTdFlJUVZtQ29QTS9iWGVXSDU5Qzdv?=
 =?iso-2022-jp?B?SFd3R1R2YnNZenNtRkJJeTlYdHNXeTh0RVJyNGszYmcwNUxiOGg2L1dM?=
 =?iso-2022-jp?B?WndIOHNqT296aUt0bEV3VjU4Sk5zYVBsYktnbTFDbGRWWmtPTVJ4UDRZ?=
 =?iso-2022-jp?B?OXY0VGRyWkkzbmIyUkFFY0FvKzUwSzBFSmJaeklXd1E0REM2V2JOKzE3?=
 =?iso-2022-jp?B?V1lQWlY1S2p6RG85T3I0dWVlRDgyVGZuU3ZoWUcvWWN2UkQzeXNQbkpC?=
 =?iso-2022-jp?B?MWhWcVVuYVhISFo3T0swa1VwTzN5SVkrSU5YTkw5ekdoWlMxUnA0b1pi?=
 =?iso-2022-jp?B?YXRjb2U4VEMvZlpCT0tORkYrRTRDQkxxN0o1ZCtLTjZXd1FQWWM1OGdm?=
 =?iso-2022-jp?B?RFc0Y2wxWlNLWVhxSHEram1DWXVvam1pcGMzSlQvSlI0cmExc1dqaUdl?=
 =?iso-2022-jp?B?d1FXT3VGWm9TNEZjOFBxYTJXb1JFdW54eHVYY3l1YWFGU1BUbWR0K215?=
 =?iso-2022-jp?B?bHVLWlFnYlNLQnF1cTRwY0dBckltU0dNbVM0MWQyQjZQMkI1ZmZLcG1w?=
 =?iso-2022-jp?B?YzNIMGdNSDBpUWlwTzhOMXp4YkxPZjdOUWNwRnBXZDBRcENGQUNVWlFm?=
 =?iso-2022-jp?B?SGJHTGVyM1FRdjJ1eHNvS0UzSXRYZ0dCUFE9PQ==?=
Content-Type: multipart/alternative;
	boundary="_000_OS3PR01MB6103DA72FFDEBC407A5900A6C2962OS3PR01MB6103jpnp_"
MIME-Version: 1.0
X-OriginatorOrg: toshiba-tsip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS3PR01MB6103.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: afb53eed-a5f5-4fba-0cf1-08dcc829a03e
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Aug 2024 12:53:48.7146
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2mke5PSsiSnX3LYGkIEQDab3MYXuKBcTJup1Sr/CICOAl9HijektYWQZXfgSBMJkKLJ41wo0kd3/+knYNtnDk9IokX9BiJTLKg61SGJcR1E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB10307
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 29 Aug 2024 12:54:04 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16833

--_000_OS3PR01MB6103DA72FFDEBC407A5900A6C2962OS3PR01MB6103jpnp_
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable

Hello Chris,

The cve-checks job in isar-cip-core uses =1B$B!H=1B(Bsmall=1B$B!I=1B(B Gitl=
ab runners. Previously, there was no issue but recently it is getting stuck=
 in the middle with this error message -> pods "runner-zwslwy9eu-project-10=
191315-concurrent-0-n51tahuh" not found.

cve-checks (#7693633828) * Jobs * cip-project / cip-core / isar-cip-core * =
GitLab<https://gitlab.com/cip-project/cip-core/isar-cip-core/-/jobs/7693633=
828>

Can you please look into this issue ?

Thanks and regards,
Sai Ashrith Sathujoda

--_000_OS3PR01MB6103DA72FFDEBC407A5900A6C2962OS3PR01MB6103jpnp_
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
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;
	mso-ligatures:standardcontextual;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:#0563C1;
	text-decoration:underline;}
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
<p class=3D"MsoNormal">Hello Chris,<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">The <b>cve-checks</b> job in isar-cip-core uses =1B$=
B!H=1B(Bsmall=1B$B!I=1B(B Gitlab runners. Previously, there was no issue bu=
t recently it is getting stuck in the middle with this error message -&gt;
<b>pods &quot;runner-zwslwy9eu-project-10191315-concurrent-0-n51tahuh&quot;=
 not found</b>.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal"><a href=3D"https://gitlab.com/cip-project/cip-core/i=
sar-cip-core/-/jobs/7693633828">cve-checks (#7693633828) &middot; Jobs &mid=
dot; cip-project / cip-core / isar-cip-core &middot; GitLab</a><o:p></o:p><=
/p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Can you please look into this issue ?<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Thanks and regards, <o:p></o:p></p>
<p class=3D"MsoNormal">Sai Ashrith Sathujoda &nbsp;<o:p></o:p></p>
</div>
</body>
</html>

--_000_OS3PR01MB6103DA72FFDEBC407A5900A6C2962OS3PR01MB6103jpnp_--


