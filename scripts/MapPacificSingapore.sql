CREATE DATABASE MapPacificSingapore
USE MapPacificSingapore

-- 1. Tìm số tiền đầu tư vào mỗi tỉnh trong năm? Tỉnh nào được đầu tư nhiều nhất?
-- 1.1. Số tiền đầu tư vào mỗi tỉnh trong năm
SELECT		[Năm], [Tỉnh], SUM([Đầu tư]) AS [Tổng số tiền Đầu tư]
FROM		[Invest]
GROUP BY	[Năm], [Tỉnh]
ORDER BY	[Năm] ASC

-- 1.2. Tìm Tỉnh được đầu tư nhiều nhất qua các năm
SELECT		[Năm], [Tỉnh], SUM([Đầu tư]) AS [Tổng số tiền Đầu tư]
FROM		[Invest]
GROUP BY	[Năm], [Tỉnh]
HAVING		SUM([Đầu tư]) in 
(
	SELECT		MAX(Invest_Each_Province.[Tổng số tiền đầu tư]) AS [Tổng số tiền đầu tư] /* Lấy tổng số tiền đầu tư cao nhất qua các năm */
	FROM		(
				SELECT		[Năm], [Tỉnh], SUM([Đầu tư]) AS [Tổng số tiền đầu tư] /* Lấy tổng số tiền đầu tư vào mỗi Tỉnh qua các năm */
				FROM		[Invest]
				GROUP BY	[Năm], [Tỉnh]
				) AS [Invest_Each_Province]
	GROUP BY	Invest_Each_Province.[Năm]
)

-- 2. Tìm Doanh thu sinh ra từ mỗi tỉnh này trong năm?
SELECT		[Năm], [Tỉnh], SUM([Doanh thu]) AS [Tổng Doanh thu]
FROM		[Revenue]
GROUP BY	[Năm], [Tỉnh]
ORDER BY	[Năm]

-- 3. Theo công thức  ROI = (Doanh Thu - Tiền đầu tư) / Tiền đầu tư; tìm số ROI của mỗi tỉnh theo từng tháng, năm
SELECT		I.[Tháng], I.[Năm], I.[Tỉnh], 
			SUM(I.[Đầu tư]) AS [Đầu tư], 
			SUM(R.[Doanh thu]) AS [Doanh thu], 
			CASE 
				WHEN SUM(I.[Đầu tư]) = 0 THEN NULL
				ELSE (SUM(R.[Doanh thu]) - SUM(I.[Đầu tư])) / SUM(I.[Đầu tư]) 
			END AS [ROI]
FROM		[Invest] I INNER JOIN [Revenue] R ON I.[Năm] = R.[Năm] AND I.[Tỉnh] = R.[Tỉnh]
GROUP BY	I.[Năm], I.[Tỉnh], I.[Tháng]
ORDER BY	I.[Năm]

-- 4. Tìm: Số tiền đầu tư vào mỗi Khách hàng cấp 1 và doanh thu được tạo ra trong năm? 
SELECT		I.[Năm], I.[Khách Hàng C1], SUM(I.[Đầu tư]) AS [Tổng số tiền đầu tư], SUM(R.[Doanh thu]) AS [Tổng doanh thu]
FROM		[Invest] I LEFT OUTER JOIN [Revenue] R 
			ON I.[Khách Hàng C1] = R.[Khách hàng C1]
GROUP BY	I.[Năm], I.[Khách Hàng C1]

-- 5. Tìm Số lượng nông dân trong hệ thống của mỗi Khách hàng cấp 2, khách hàng nào có số nông dân cao nhất?
-- 5.1. Số lượng nông dân trong hệ thống của mỗi khách hàng cấp 2
SELECT		[Khách hàng C2], SUM([SL Nông Dân]) AS [Tổng SL Nông Dân]
FROM		[Invest]
GROUP BY	[Khách hàng C2]
ORDER BY	[Tổng SL Nông Dân] DESC

-- 5.2. Những khách hàng C2 có số nông dân cao nhất (Bao gồm cả trường hợp khách hàng có số lượng nông dân bằng nhau)
SELECT		[Khách hàng C2], SUM([SL Nông Dân]) AS [Tổng SL Nông Dân]
FROM		[Invest]
GROUP BY	[Khách hàng C2]
HAVING		SUM([SL Nông Dân]) = 
(
    SELECT		TOP 1 SUM([SL Nông Dân]) AS [Tổng SL Nông Dân]
    FROM		[Invest]
    GROUP BY	[Khách hàng C2]
    ORDER BY	[Tổng SL Nông Dân] DESC
)

-- 6. Có bao nhiêu khách hàng mà công ty đầu tư nhưng không tạo ra doanh thu trong năm?
-- 6.1. Thống kê số khách hàng công ty đầu tư nhưng không tạo ra doanh thu vào mỗi năm
SELECT CWR.[Năm], COUNT(*) AS [Số khách hàng không tạo ra doanh thu]
FROM 
(
	SELECT		I.[Năm], I.[Khách hàng C2], I.[Khách Hàng C1], SUM(I.[Đầu tư]) AS [Tổng số tiền đầu tư], SUM(R.[Doanh thu]) AS [Tổng Doanh thu]
	FROM		[Invest] I LEFT OUTER JOIN [Revenue] R 
				ON I.[Khách Hàng C1] = R.[Khách hàng C1] 
				AND I.[Khách hàng C2] = R.[Khách Hàng C2] 
				AND I.[Năm] = R.[Năm]
	GROUP BY	I.[Năm], I.[Khách hàng C2], I.[Khách Hàng C1]
	HAVING		SUM(R.[Doanh thu]) is NULL
) AS CWR /* Customer Without Revenue */
GROUP BY CWR.[Năm]

-- 6.2. Bảng thông tin chi tiết về các khách hàng công ty đầu tư nhưng không tạo ra doanh thu
SELECT		I.[Năm], I.[Khách hàng C2], I.[Khách Hàng C1], SUM(I.[Đầu tư]) AS [Tổng số tiền đầu tư], SUM(R.[Doanh thu]) AS [Tổng Doanh thu]
FROM		[Invest] I LEFT OUTER JOIN [Revenue] R 
			ON I.[Khách Hàng C1] = R.[Khách hàng C1] 
			AND I.[Khách hàng C2] = R.[Khách Hàng C2]
			AND I.[Năm] = R.[Năm]
GROUP BY	I.[Năm], I.[Khách hàng C2], I.[Khách Hàng C1]
HAVING		SUM(R.[Doanh thu]) is NULL