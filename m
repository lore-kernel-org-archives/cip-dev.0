Return-Path: <sai.sathujoda@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C07C2C52D7D
	for <webhook@archiver.kernel.org>; Sat, 17 Aug 2024 13:34:52 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.152])
 by mx.groups.io with SMTP id smtpd.web10.170245.1723901686015225280
 for <cip-dev@lists.cip-project.org>;
 Sat, 17 Aug 2024 06:34:46 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.152, mailfrom: sai.sathujoda@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1802) id 47HDYhJW2434593; Sat, 17 Aug 2024 22:34:43 +0900
X-Iguazu-Qid: 2yAapsDzD4JZ3ve1uy
X-Iguazu-QSIG: v=2; s=0; t=1723901683; q=2yAapsDzD4JZ3ve1uy; m=E71EKXkckXm1AMhOOvF9Px3EOy4LhkKkzr/OPv9dl/o=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1802) id 47HDYfoN3120237
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Sat, 17 Aug 2024 22:34:42 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PpOeSpXf4RVhsDbEYjYqJSXxoQDRXr3Hz32QiuBM42uMM1NrifWYw7FFflcbl70I3YIzZtgSq6c4DZ15Awl6LGGmC3N2/N5Tv6gKoxM6ow0MKoYz5OS3cVGdlb4jll4RbFHqKZQKckkQ097mb+GAYyhtsPZjYVVc3eE5ZTSL0pwB58iafwLtv/N1XidVMNsCMN3gx9un5EGNSrrw685AGjB3EP3Jk+KqleIc1K+g+yV3r0bP0B3+I5jzxuRN/n/ltc8OMYPuncfn5p2pu4C/uhJqn5T/KLgr8HCqJ1g+ccS6LSnj0Eb8NU1kYgOEIl+FGuXvnKZKsgnHnfw8vTNFqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xz77T52ZSHjEvgNxu098+eLhApPaFyjq7wuMb6kwhuM=;
 b=AoD0/FRnKx1bqhxYfZOwpWfbN4H/EtPcKBcCAV+G5ZX0iGh/IHjFv+4ZPk8Wwgwh5vhCf1N7RcP7gRGHewFcEqKdOxPR+6wPYEQH3X/7LKfwOz5v93zW7kr2Xo31rJxOSFT/dBaQQjYH3GvGnagHlENKeyMr9yp0klabiK9N9R1uPcJjJO/5z7yohahO+nfZVioftTcqRsy/oq0mJGwqBZf7a83ObTMhxq2h7+Nc/3vVPOhkzwbthT6D+wH/PsiUvtFIt0kqXp3OMymTYmzzXrb8xnvFYNTna/uV0LT15+i8dLg84t8FwjCsmmYro+azAQjaGtwNfcNPYEzJNwxa7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba-tsip.com; dmarc=pass action=none
 header.from=toshiba-tsip.com; dkim=pass header.d=toshiba-tsip.com; arc=none
From: <Sai.Sathujoda@toshiba-tsip.com>
To: <Chris.Paterson2@renesas.com>
CC: <dinesh.kumar@toshiba-tsip.com>, <kazuhiro3.hayashi@toshiba.co.jp>,
        <cip-dev@lists.cip-project.org>
Subject: Request for review
Thread-Topic: Request for review
Thread-Index: AdrwqfOJexZyUCBeTkaCBtxP0Npn+w==
Date: Sat, 17 Aug 2024 13:34:38 +0000
X-TSB-HOP2: ON
Message-ID: 
 <OS3PR01MB6103FF8F52601E0BF4BE297DC2822@OS3PR01MB6103.jpnprd01.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba-tsip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS3PR01MB6103:EE_|OSZPR01MB6861:EE_
x-ms-office365-filtering-correlation-id: 14388376-c7d4-4c91-9aad-08dcbec15793
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: 
 =?iso-2022-jp?B?Tk5McjdUVlZ3VHc1NVVuMzc0eVJDdzVFVlRMUGhLcjdqSEx0QlU3TXpq?=
 =?iso-2022-jp?B?NkZPU2ZUM0RiYzUxbTdrVmdiT2V3cHRjV01VOEdLWmI0b0hlOHhQZitk?=
 =?iso-2022-jp?B?cjNsWEtINDFOeEw2T2FETWFrZS9NQlR0NlpjQkFsc3J5NU9NV1FSSC9q?=
 =?iso-2022-jp?B?enJzR2N0TkovN25FOVlObCtHUDZNK0hmYU5mVnRPa05WWDhTWFJzS0Fm?=
 =?iso-2022-jp?B?cHd3ai92M1ZHVGFzN0FTaXBRQUdoOXdPeC9qaVQ3Z3RjTlM0UEhRbVVJ?=
 =?iso-2022-jp?B?bzU4c0cxQ3dYdk9NRUJFWTU5UFA3RnF4UFBVWnd2bGdUaDRmNHhUU0x4?=
 =?iso-2022-jp?B?bzRBNFExVWI5Y2l3ZGVwK3ZySmtKVDFOaUY0WXp4VkJPb1V3R1FUZ1dV?=
 =?iso-2022-jp?B?WHNlbC82bzN3NVRJbGlOaTFzT0dMNGxLUVErWXl4NS93MFA0UzJpYVVw?=
 =?iso-2022-jp?B?Q2hKQzQ4TUhQbDRFMXF6SHB5UkhhTjlDSHEyckxXZXN6SXJ0Z3JqcjJ4?=
 =?iso-2022-jp?B?WmRIRHBvTGN2ek5xZnBtVWZ6ZEZKMFZwRnRlVzBLSE5nYjc3UGhoTjEr?=
 =?iso-2022-jp?B?c2JpaHphUFRDa1VYYW1BWXR4VHVreFdnMGZ0QUZLSTJ6b1J2bHY1ZkNp?=
 =?iso-2022-jp?B?MFl3bjNTVmh2Z2c2QWQzSm5KdlZjaGFVaFYvUUZxSFdlVkxOSFkrZ0RX?=
 =?iso-2022-jp?B?YjAvR29od1k2Y051c3d0eEhPTWNIeWhBbWFEQ0dQRWRaUVlpblZwNW1P?=
 =?iso-2022-jp?B?dFlMSmsrWHdIMGlkc3BOSnRWcTNYQWNvdUVjRUZ6dURGbzNsVnQxdkhB?=
 =?iso-2022-jp?B?MEUwVUxFc1E3Ylczb1VtcEt5YlFqTDV5Zy9BVlZ5WFJwWlVHREtwWXVU?=
 =?iso-2022-jp?B?MStvOHE1OGZIOUEvY2ZGUGsxdXVwMEdVSVlXdE0zc0M1bUt2aXhodnRR?=
 =?iso-2022-jp?B?TjhGcTAyMjNkS3h5MlF6OUtHSkI4RmUzb0VLRlgxMjl2OWR0QUFoVE5J?=
 =?iso-2022-jp?B?TWFJem9peVdZVlExVDZpM2ZMVkh3NlQvYk05Vnh3M0ltbmJWUUJYVjFU?=
 =?iso-2022-jp?B?Wkp4eEpCOEZiSkhNVk5KcHQzK1hZWkNjTlRLYVJ0S1VLeHpGUjVRUHpp?=
 =?iso-2022-jp?B?bE5xRFduQWJ2YmR0ejZ3NkpoT3JHR1hEcW1WcUhJM0Q1WUJsZktjWGla?=
 =?iso-2022-jp?B?YkY3aE1ac1FpNitVQ2c4WE85amlrS3lOMjUzdjAzUnN3cWF0NHNCZi94?=
 =?iso-2022-jp?B?bTErd0RmKzkwYmxBYld4bEVEejV5UmdHVCtpcFJjZnpmVHpSWTFSR0Zt?=
 =?iso-2022-jp?B?c1I1ZWN0NTNCQ3hXL2FrUVVGSUo1eGxwR2RKSS9rWUNTdkNjQ2FlR01C?=
 =?iso-2022-jp?B?NVZkV3JHTkhmSjcxbWVDWkRISmIrQlZTWXBOUU5lYTVuamZ3T3BjaWxR?=
 =?iso-2022-jp?B?V1prWExUdkQrMUMyV0ZyYmEwN0xrMWNjZjRDcUZjUUZSN2dVa3BUZ05G?=
 =?iso-2022-jp?B?ZUJLMEFyOVNZMVpwakhSTkNnaDk5eStTcXJlWHJTbHVtY2ZQQWltdkk5?=
 =?iso-2022-jp?B?TUtKcmZSbDRFZURhOXJrb1VVS0NCR1o4VkdFT296M3hLVGtxelJORXdL?=
 =?iso-2022-jp?B?WlNueTQvRlFwNmZSTDlmWU1IYnU2TXVDWklEY3k5eitqN21WRXU2emtW?=
 =?iso-2022-jp?B?RFF1S1ZZQVNHS2hnY2Rrbmg4amxCSzR1UU1STFNXakw2ckErUE82cmFK?=
 =?iso-2022-jp?B?T2FQMWdjbUJoV2hJaHpxRXNNWHpJQ0xoK1U4TC9EZU5RU1plL2o3ZUZE?=
 =?iso-2022-jp?B?QzhBT1drRXNrdUhOWWNPRzJJS1hlVUkxUlRudUlaaHVVeHEvQlBOc3pn?=
 =?iso-2022-jp?B?alh5ak9uUkFMWUQ4NjJiODlxVHRNL2NCdVhoUUhQenkvK3F4ZEFDOW4r?=
 =?iso-2022-jp?B?eVMxNVJWenpKUHY1bGpyVzJyOUZ6cVpUcmtBbUVEcUpFR3ExdE5nTlJM?=
 =?iso-2022-jp?B?MmpVdTlnUXM3TmZmdDdmT05zQkt3aFMxK1RjQStna0RNY2lGdUpGdjBz?=
 =?iso-2022-jp?B?RXc9PQ==?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS3PR01MB6103.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?RWY5bzRheVhWVWFSeXpiODN1YTNIMFE5OURJejB6VnlWVEpsa25oNk5h?=
 =?iso-2022-jp?B?ak11RlBoR3VBUnE2T1Bkd05hQ0RCQURzM0lIOUlJUXlOK2Z0amIvQW9v?=
 =?iso-2022-jp?B?ZXE4M2N5aW5LVkZJcUk0YVc4dmUyWkVET1BPZzFiVGJxOW1lM2JzRkhX?=
 =?iso-2022-jp?B?bzJaYUw5ZlZjd1BranQrdVJjSCtFbWRoWktzVHArT0x6V3B4RTdpYVdB?=
 =?iso-2022-jp?B?aVlTMk5ZcHZzNmJTcTlycHVLbTM2Rmk4b1BsNVREZS93WEZBYVB4ZkJa?=
 =?iso-2022-jp?B?YUxwZitMUEgwVjhmb1lTWURyWjhGMXMwVzlOR1F3alRaZzFnYkpRRWFs?=
 =?iso-2022-jp?B?QmdWZ1phMVkvRjBtNFBQMmk4NTd4NnNMWFpTa3MvSlBSQ1Q1Q2VhaXBY?=
 =?iso-2022-jp?B?ZWd4Z2NoVHE5TkVaNDJ3K3ZvcklNeDFSTmJHOEk4SElUbzFKUWhrRjkx?=
 =?iso-2022-jp?B?bDhCYnIxUDBGUmxxL3ZYdXZqdXN2UUE1elc0STI4NVh6Y3RTZEVnNzh3?=
 =?iso-2022-jp?B?YnpZdWQweFE1MzMrTm1BK1FQdW5TZS9vMWtrSERHWlNiekJITis3VFJY?=
 =?iso-2022-jp?B?b0VaV0t3dUt4bDlhSGlpY0ZPTVdvRlVJZjRsTkZiL3N5YVBPUm55Z0Ro?=
 =?iso-2022-jp?B?M2Fyb0JsdVp3TjRkQjFXME1qdUhrS2RvTW9VVjQ2a2VaMXlDWnlVekg3?=
 =?iso-2022-jp?B?eHAyQjMvNWlPeVpaRzZwWG1BOTlMY1RwczJISVFMMUJBT1JySlpyU3gx?=
 =?iso-2022-jp?B?c21UMzZDcnNmWEVYb1l5NC9sUk9VSTNhVmFvQkJ5VDdVMUR5WjRjK2RU?=
 =?iso-2022-jp?B?c3l0U2ovVFZQYkFYci84dmhyVG1hNGVXdXk1ZUdjb3UxRDJKcXpyRHJi?=
 =?iso-2022-jp?B?dHloblJ5T1BLMm94ZVVhMVlib1ExZ3IxcFR2cmx1dTdNOTU3ZHlUa2w1?=
 =?iso-2022-jp?B?Q1AxNWpjSnRUVkRuWXhhS08zdE4vdHg5QlF6dUo4MTNHcE5XQzZvVnBn?=
 =?iso-2022-jp?B?NHhPcnJaejBJai8xbklUd1RiQnZqZ0Q5WTZha0F1dkxpd3NSWTF4UnI2?=
 =?iso-2022-jp?B?RW5taGFUbmdQTnlXQnpQa05mS3F6QmZ2Z0tJbUFkYTFQODR6Y0J4R1A5?=
 =?iso-2022-jp?B?RVVmcGlsNnpmRjFIZ2p5MmNzT0NOaHYyVjlka09iNWdSMTROTHpzV2dK?=
 =?iso-2022-jp?B?MFJrY1FSZUkzZ1JGcDZHYStxL2xQWXJpbFFDelVudEpQMzBZNVRWcHIw?=
 =?iso-2022-jp?B?K1gwQ0t1QU9rN0M5UGpPMG0xeHk0T3hVMURvdzBoVS9lT2tnVHVyL2pt?=
 =?iso-2022-jp?B?TzZYaGdnZ293SUJqWDF0ZXhvWHVhWXZZWG0xbnIwL3AzVXpIaUhjNGc3?=
 =?iso-2022-jp?B?aGN4NW5pUnkyekdiOFpzM0d2WCtHMFB0Z3lKc3lYSktLbHlRZ2RjYUlZ?=
 =?iso-2022-jp?B?THpXT25LZ1RTd0JKZUJJYjhCYWxpWVdxbGZEVXNLeHZiZVJUR25BblZQ?=
 =?iso-2022-jp?B?TUtrL3hTTTJiQkVOS2x0Snp1TVh3THg3WTRtdHRVVHd2c2V2bEFxTUMy?=
 =?iso-2022-jp?B?OEpXQVdFZ2FVUnRCb2VoYThNdTdvd1Eyek9RQWtFUVcxK1V6bXIrVTJQ?=
 =?iso-2022-jp?B?YlYxZlRUSTZ0bEM5ZDhqRVdZc1RBemMzREJaREh4MGNaUXlJOWNpeGU3?=
 =?iso-2022-jp?B?dmkyOXY2Vm1keGhQM0ZuVDYrbEhZb29CeUhyS3NONEgycU5mOXdzaDQr?=
 =?iso-2022-jp?B?NFkwcXdnQ05sOFBsd1lLZi9NZEtNazl0VG5FRUlCTitZdHdqV3ZYYU5T?=
 =?iso-2022-jp?B?VWhVRnRqYUhjL2UzWkl3bkVrSk9Lc2VYNERTVkgvREFaeFlrWE5WWWtE?=
 =?iso-2022-jp?B?dENXUkdxaFBFRGVOYTJWVEVFb2ZRYUJ2a2NiRTg5eU1CS3VXUkJad0Rl?=
 =?iso-2022-jp?B?OEZWWmx1NHdlTCt4Ui9UNVgxQmJqYnBJNlorR25wcUlhOXBocWFielZj?=
 =?iso-2022-jp?B?V3dUTFB4OFhVbjU0MzVlNk1wRzJoR09Vd2g0UCtxZG9XTitVK1hEaktR?=
 =?iso-2022-jp?B?d0J1cWU4VHpGTnNkZTBiWmJTdTkrejNtVDlJUGxaREpheHZmc2ZjRFNi?=
 =?iso-2022-jp?B?QjY3bmtRNEIxMThKeW96M2k0UmhwbXZheVE0SUlnOGxtaUxsQUowenBP?=
 =?iso-2022-jp?B?TTNFb05FREFhaWU0ellLUXBPNStUMGRaNDduZ2hzQVF4UThhL3lBbURa?=
 =?iso-2022-jp?B?enVDbUEyNDRNMHpsMGp3eHlBZHFVNmg4NUpwMFZEYlZkRE5VM2J2S3B2?=
 =?iso-2022-jp?B?dXROUzJzVU1mbEpTK2xSTHNud3VycmJWdWc9PQ==?=
Content-Type: multipart/alternative;
	boundary="_000_OS3PR01MB6103FF8F52601E0BF4BE297DC2822OS3PR01MB6103jpnp_"
MIME-Version: 1.0
X-OriginatorOrg: toshiba-tsip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS3PR01MB6103.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 14388376-c7d4-4c91-9aad-08dcbec15793
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Aug 2024 13:34:38.6749
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0FjT7afkMi8/NX+2SsAsx/WnZdXqBltWF8Wm4JcIWNu+3RGIw5TW8GjIVi2CdQ8uTD19B64+rRXx0TpvwamytTFDXsP09nx+UmQAzpn8I8o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB6861
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sat, 17 Aug 2024 13:34:52 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16792

--_000_OS3PR01MB6103FF8F52601E0BF4BE297DC2822OS3PR01MB6103jpnp_
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable

Hello Chris,

Hope you are doing well.

I request you to review this MR Generate IEC layer test reports from SQUAD =
(!4) * Merge requests * cip-playground / SQUAD Hacking / cip-release-report=
s * GitLab<https://gitlab.com/cip-playground/squad-hacking/cip-release-repo=
rts/-/merge_requests/4> and kindly provide your feedback.

Thanks and regards,
Sai Ashrith Sathujoda (T S I P)

--_000_OS3PR01MB6103FF8F52601E0BF4BE297DC2822OS3PR01MB6103jpnp_
Content-Type: text/html; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable

<html>
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
<p class=3D"MsoNormal">Hope you are doing well.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">I request you to review this MR <a href=3D"https://g=
itlab.com/cip-playground/squad-hacking/cip-release-reports/-/merge_requests=
/4">
Generate IEC layer test reports from SQUAD (!4) &middot; Merge requests &mi=
ddot; cip-playground / SQUAD Hacking / cip-release-reports &middot; GitLab<=
/a> and kindly provide your feedback.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Thanks and regards,<o:p></o:p></p>
<p class=3D"MsoNormal">Sai Ashrith Sathujoda (T S I P)<o:p></o:p></p>
</div>
</body>
</html>

--_000_OS3PR01MB6103FF8F52601E0BF4BE297DC2822OS3PR01MB6103jpnp_--


