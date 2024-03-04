Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F03A9C54E49
	for <webhook@archiver.kernel.org>; Mon,  4 Mar 2024 16:30:20 +0000 (UTC)
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (EUR04-DB3-obe.outbound.protection.outlook.com [40.107.6.53])
 by mx.groups.io with SMTP id smtpd.web10.103943.1709569816245361540
 for <cip-dev@lists.cip-project.org>;
 Mon, 04 Mar 2024 08:30:16 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=rvNtnWm4;
 spf=pass (domain: siemens.com, ip: 40.107.6.53, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=juE9cZd9MaW2UthL/dqAXGi46msLECGCL/h/mNUQJlXLUOSLZTqWOHlST2/0frsT3ilBTZ4TtPh0LjQoflCcCgWKQUFsszHskXLTQd4OGuOA3PPUwQJzsPYOI5ccRLzNhJNodC0vJYwrfIfMJgNv69JfptiKjvG5gqOmqNkPtNwuHtRTep3ldy5tEzokrunXAYUmHUCRMFu1YIQX653Dd7vFKwTVVNpRv9EOHr4659+QrF6KGznjjn0jex1E8WsaiHOLOFinvonldnWUFQnh2ya26QVCxgvRALYXsVoWq54q4KCXm4TbTzhXqG/TBuFlbVMzB7QGjYHew115aOKOmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=49kuT9jDOyyiXTSznZNIfO+FuhjMkZXRJCCxBzX1CQ4=;
 b=FShiCgCBThZ5s33D2dorKdoZlz/ivZO0uGIOhex5o5Y60zgnZDRgOS8vtKKJe1Mx0t/7tn0rL/dx/4uOVsBxBMy+Bc5QuOssvDDgZg24Yh22PzNQE+qAfV/Ia7dnNQVv1VPGIJcg55e7v55RoxsGa4axvtGtRHdpo+le/YOFxSybxjJHg9VUfoKzk1FqL6pLT7VK21WfMfNuTt7L7yDSAm3iLocYRawHGXzmN5V3Xzx41f2aXbQs/3ys14YlIAZcC544PTrEkSEYs21vlkgRozhM+TFToSc8BBw0/qAkVEss14P1++pQGoVhGD/HkuO0mNvblYkRA2JqAamvNboq1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=49kuT9jDOyyiXTSznZNIfO+FuhjMkZXRJCCxBzX1CQ4=;
 b=rvNtnWm4HElR+Otj+T291uS6Mekm2f4HEq8IYc0/DGflOZLOuOiO6CVtXZe8fJnSSBuMhuqYL/fBL6XK2aOl4dyHH+ImxHOaccMAxo62LJCpuFUF2oroTqcX1bBIGqNEw9Vy7Lv0x6552TA7GcMKFNhsNxMUwQfgUofQhnjvbFXSXi6CDA4uG+VZKD3gu0N+Sldx9RBOoW416GFovbVU8b3jiHvrJbAH1v05+gxhmGks8/ODXNkca/Oe+5/g5r3kI7a10uYOcbpHZaf9qVW0el5rGACXNfP9axw6BLhTu0j/fuVj0WKFKviogITZaaqgcqtSFbRRaMJJvBVAlaraRA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1f9::22)
 by DB9PR10MB7268.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:45c::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.38; Mon, 4 Mar
 2024 16:30:13 +0000
Received: from AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::67a7:ac13:3db4:91cf]) by AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::67a7:ac13:3db4:91cf%7]) with mapi id 15.20.7339.033; Mon, 4 Mar 2024
 16:30:13 +0000
Message-ID: <eb90f40a-01df-4fee-9f28-7013d9a55a29@siemens.com>
Date: Mon, 4 Mar 2024 17:30:09 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev][isar-cip-core][PATCH 1/4] swupdate: check output of
 sign-swu
Content-Language: en-US, de-DE
To: "Moessbauer, Felix (T CED OES-DE)" <felix.moessbauer@siemens.com>,
 "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
 "Kiszka, Jan (T CED)" <jan.kiszka@siemens.com>
References: <20240304101054.864948-1-Quirin.Gylstorff@siemens.com>
 <20240304101054.864948-2-Quirin.Gylstorff@siemens.com>
 <68ac280ab269175e7ac6015a50f54daa7183ed90.camel@siemens.com>
From: Gylstorff Quirin <quirin.gylstorff@siemens.com>
Autocrypt: addr=quirin.gylstorff@siemens.com; keydata=
 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
 XSdq0hnpafc1V+voPJq3LMxUvLNrwg==
In-Reply-To: <68ac280ab269175e7ac6015a50f54daa7183ed90.camel@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: FR5P281CA0035.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f3::11) To AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:1f9::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4085:EE_|DB9PR10MB7268:EE_
X-MS-Office365-Filtering-Correlation-Id: 52504a74-571d-418f-2b56-08dc3c685df8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	engVXx1rLzAtEZoUuR7Wy+EnWHtIGA+6vMYM9awvi9+CFdvJuzkQcHw/Cjyi4RpuXh9YJWu+FaKaPfcUtwHX5fQIOqgtFkXh8v7qgLaGNU63XaGYqZl7ZrDqybBttFl+OndDCpSRLy53xcVzmTBumP1tFD5k9kiRAW/sdOGVibAPfQ0GQMDywqM0Odg1JraMUIwkt1QYTZojgAjj/89TDjuFhYm1kCOislwU1jguJbcsnFexjRNAGRer3Qhu8FYnSZJoAAQtU9lzzdLqkE9eeFBnuhTK9wYKXPM/faDDMyVNaPsSRvqxExBwGnXgxgkoREBO1Y55RLPh79jCZ2b+VxwT0box5sZC5u9iX2m4aNmimCkLRKdZHNi0/K1okkkdonLoKE6JilDjFS8KOhzFwWmPHL/qyha7Se7+nPObBEBpOmGM+Y4UP1BafDWKYITS9jzJ1M7A7OQq5C2GeyYpbzltdZc1kCY0QN73P5kqtSLpxr+YsS1v8W+n9iR32Ne4Z5S532a3/ldor33yZkZuAJsJWWVrMXwFtF2jpWBYiCm0/hf5JDNuicWtxTnwsiwWPdXrhY89IwB3gaeD9i2aqYCQtAyLPq7XKtqzU7+CQlcXt+gNQKZ+Nsv55ZTKGHy4JIynaJRi2/yoUCsxhONGliaXvugVyWFATyCMze/qj3Q=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?BpqmtcB5oG3Y8e8Vzhxy0uKTFWKNZOKQjY7g7n/5fXZAG896Toixhbn2D07C?=
 =?us-ascii?Q?5yLFERJ0oYVC9LzoSM/AUqMZAUoHb1g16vUEzBepZHhreqJpKXy6A23GjNRE?=
 =?us-ascii?Q?d/CGxslaPffUkO6A4t63oI6FIjFVTmz+D3+ybDyG1xiFY5viJJIbTlOl93XW?=
 =?us-ascii?Q?Zrg+l0Sh9isz0hCEClMCCJO5OHy5NyMO6h4UKN0LdY1BxxKhtVf9qN99jyu2?=
 =?us-ascii?Q?JqFrfs0LeWfJXv4955F4/K+7FtjsTeAsRtsk+kMlo3CLzkFqqCdhTP9DgUJz?=
 =?us-ascii?Q?aKmfi8tkSyytc1/l6msvPFUElWJcjYVJFC1Y9A2zxQLqRPC/rm/FW5cwhsC5?=
 =?us-ascii?Q?ZLMljOT1jispEhgo7qEuFu8W2Rd7DhAJKs2sVOFxT+bScrJ0imcGLgRQnzhU?=
 =?us-ascii?Q?qxg8QILtCLNcUjLWcKIj8/HvnXxbjlgdTGbWI9Kjvkb5MPI25Ocm0Qp9p75z?=
 =?us-ascii?Q?cJZjrFUdHiuel01DVDtj4q7TszHegrV4V6ybPwoR2fV6YYtjlQvcAGDs0Dh8?=
 =?us-ascii?Q?dELEDoroaNC+V3PFuv/GaRtHZPgHruWsyj622KOi9pgwo1TUUtEYR4kHjjge?=
 =?us-ascii?Q?0htyyRVPMV2rBQYoAMjeV0r3dR2L6WyZUzeqGILdUuG0lMPBQ1nXm+UO4xxM?=
 =?us-ascii?Q?eoWiG5AcEaYpsHFrP4QpoBGAwKx8xtYp4yEGQYA0r17UD6F9QsHAvQDUMl0T?=
 =?us-ascii?Q?XaBcHRZgwEuUDVKusPqrjGxBimpVdJdsQGFE2anR2P78suJ7xTqrxzm1iyBd?=
 =?us-ascii?Q?2dtMiwv8VEcCVzNaGWyYb2S0hyf3y9wJe9nKjxBCA5DzcDmyJoL14PpcUs0u?=
 =?us-ascii?Q?w6etf5QuVDMhAevNUR94HM23Zg5ZEHWf6wFMhNZXej+muIZl74xenwJV6Ij6?=
 =?us-ascii?Q?R56aJlQpjwCA0+E0kreP2WVudcGslQSiS5YRvZratPsQwr6x0DreWGwHVg36?=
 =?us-ascii?Q?6s5U7SA8d3GbQ4PAa6ScV4FNsHPV4R1ZjMfsNzC6nrS+mIQEQON248XDuz8c?=
 =?us-ascii?Q?4ZObL+O6K/NhhLU3X4vb53vX4ToTHmtW17WaSh8NLzmfyfVAWcpfez2rVY2l?=
 =?us-ascii?Q?z0dY0qZqKSS3rIh2Yh76W8S27WfhVS13R21PJuHXgrV0AaUX5t417wDZPDB2?=
 =?us-ascii?Q?DBnsSy20I3KBS30u4jttnC0vwQeqdsZJ9aG0jviiMNdThRTBA/K4VXJa3hp4?=
 =?us-ascii?Q?HfSq/fFCsoHoI3KZ/yFHdrOefQOLeKvU5MkojvSTdRk5/OmPJBjwGD1/3i0X?=
 =?us-ascii?Q?eFBMJvWJcpZgO1f3sKvc2mRYN0re83Bn6De4H9IZaOdR7ZifJgG4fw7CNjgj?=
 =?us-ascii?Q?VFMYr82K0ZaUYuVPjznGpbXCHO4/c1TI/aSfelRXJxWJJvqLa61I0s0Lbc5V?=
 =?us-ascii?Q?sjbmt0PbdSLcDEMqjfQfTJ9aYKUfKHWt14lAV1K338fVGCC0B+x81SA/czpn?=
 =?us-ascii?Q?WFHuWkGZDc4//Ca2piT6EDNNmV5xPV/LTQfbdfEYlXWSW2so6Ifay8+uo/6+?=
 =?us-ascii?Q?QLo2T4t7wr3WMQ5nVV5SvF8zjoUtxRVfuvO+DSlp1tz8v1j1qcB1mlWX3TkR?=
 =?us-ascii?Q?dQUvINuOATAo+5IntVdydEqGdJcu4TVlbP9xE9Jz/CyWbLPVc47a/tE/tIRo?=
 =?us-ascii?Q?IQ=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 52504a74-571d-418f-2b56-08dc3c685df8
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2024 16:30:13.1687
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XJJUaCipKMhFGNIltoJs3w1sN2KienDr4+PtdyTI5l+SPcVY+cy3yDN11x98O/RuagnsBGVGf/PPodFsCx1Bvr+EaEhu+lIotUkkCGcfon8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB7268
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 04 Mar 2024 16:30:20 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15200



On 3/4/24 2:42 PM, Moessbauer, Felix (T CED OES-DE) wrote:
> On Mon, 2024-03-04 at 11:08 +0100, Quirin Gylstorff wrote:
>> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>>
>> Check for signing errors to avoid an unusable swu file.
>>
>> This also moves the siging out of the loop to generate
>> the cpio archive *.swu as the Messages from the signing
>> can lead to errors in the archive generation.
>>
>> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>> ---
>>  =C2=A0classes/swupdate.bbclass | 43 ++++++++++++++++++++++++++++-------=
---
>> --
>>  =C2=A01 file changed, 30 insertions(+), 13 deletions(-)
>>
>> diff --git a/classes/swupdate.bbclass b/classes/swupdate.bbclass
>> index 2c69892..be6a07f 100644
>> --- a/classes/swupdate.bbclass
>> +++ b/classes/swupdate.bbclass
>> @@ -191,24 +191,41 @@ IMAGE_CMD:swu() {
>>                     =20
>> "${PP_WORK}/$swu_file_base/${SWU_DESCRIPTION_FILE}"
>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 done
>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 cd "${PP_WORK}/$swu_file_base"
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 for =
file in "${SWU_DESCRIPTION_FILE}"
>> ${SWU_ADDITIONAL_FILES}; do
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 if [ "$file" =3D "${SWU_DESCRIPTION_FILE}" ] || \
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 grep -q "$file"
>> "${PP_WORK}/$swu_file_base/${SWU_DESCRIPTION_FILE}"; then
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cpio=
_files=3D"${SWU_DESCRIPTION_FILE}"
>> +
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if [=
 -n "$sign" ]; then
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 if ! /usr/bin/sign-swu \
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "${SWU_DESCRIPTION_FILE}"
>> "${SWU_DESCRIPTION_FILE}.${SWU_SIGNATURE_EXT}" \
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > /dev/null 2>&1 || \
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 [ ! -f
>> "${SWU_DESCRIPTION_FILE}.${SWU_SIGNATURE_EXT}" ]; then
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 echo "Could not create swupda=
te signature file
>> '${SWU_DESCRIPTION_FILE}.${SWU_SIGNATURE_EXT}'" 1>&2
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 exit 1
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 fi
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 cpio_files=3D"$cpio_files
>> ${SWU_DESCRIPTION_FILE}.${SWU_SIGNATURE_EXT}"
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fi
>> +
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 # sw=
-description must be first file in *.swu
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 for =
cpio_file in $cpio_files ${SWU_ADDITIONAL_FILES}; do
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 if [ -f "$cpio_file" ]; then
>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 # Set file timestamps f=
or reproducible builds
>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if [ -n "${SOURCE_DATE_=
EPOCH}" ]; then
>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 touch -d@"${SOURCE_DATE_EPOCH}" "$file"
>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fi
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 echo "$file"
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if [ -n "$sign" -a "${SWU_DES=
CRIPTION_FILE}" =3D
>> "$file" ]; then
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sign-=
swu "$file"
>> "$file.${SWU_SIGNATURE_EXT}"
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 # Set=
 file timestamps for reproducible
>> builds
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if [ =
-n "${SOURCE_DATE_EPOCH}" ]; then
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 touch -d@"${SOURCE_DATE_EPOCH}"
>> "$file.${SWU_SIGNATURE_EXT}"
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fi
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 echo =
"$file.${SWU_SIGNATURE_EXT}"
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fi
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 case "$cpio_file" in
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sw-de=
scription*)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 echo "$cpio_file"
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 ;;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 *)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 if grep -q "$cpio_file" \
>> +
>> "${WORKDIR}/$swu_file_base/${SWU_DESCRIPTION_FILE}"; then
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 echo "$cpio_file"
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 fi
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 ;;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 esac
>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 fi
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 done=
 | cpio -ovL --reproducible -H crc >
>> "${PP_DEPLOY}/${SWU_IMAGE_FILE}$swu_file_extension.swu"
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 done=
 | cpio \
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 --verbose --dereference --create --reproducible -H
>=20
> We now have more options like --dereference. Does this have any effect
> on the cpio file, or is it just an expansion of -ovL (which would be
> appreciated anyways)?
>=20
Its just an expansion of -ovL as I expanded them during testing. I will=20
send a v2 with an apended commit message.
Quirin

> Please also add a note about this to the commit message.
>=20
> Felix
>=20
>> crc \
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 >
>> "${PP_DEPLOY}/${SWU_IMAGE_FILE}$swu_file_extension.swu"
>>  =C2=A0EOIMAGER
>>  =C2=A0=C2=A0=C2=A0=C2=A0 done
>>  =C2=A0}
>=20

