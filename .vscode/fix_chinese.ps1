$file = 'c:\Users\Mohamed Gamal\Desktop\capacity-dashboard\index.html'
$content = Get-Content $file -Raw -Encoding UTF8

# Fix Strategic Insights summary header
$content = $content.Replace(
    '<span>💡 关键洞察与发现 — 点击展开/收起</span>',
    '<span>💡 Strategic Insights & Key Findings — click to expand/collapse</span>'
)

# Fix h4 counterintuitive findings inline text
$content = $content.Replace(
    '>🤔 反直觉发现需进一步排查<',
    '>🤔 Counterintuitive Findings Require Investigation<'
)

# Fix adj-counterintuitive-body (restore English inside this data-i18n-html block)
$oldCounterBody = '<div data-i18n-html="adj-counterintuitive-body" style="color: #6b21a8; font-size: 14px; line-height: 1.8;">
<p><strong>1. "待改善"季度绩效合作商仍出现净增加：</strong><br/>
25 个被归类为"待改善"的合作商获得了 +117 净骑手（均值 +4.7），而"良好"合作商净减少 -348（均值 -8.1）。</p>
<p><strong>2. FR 与分配存在错配：</strong><br/>
高 FR（80-100%）承担了 -322 的净削减，而 70-80% 增加了 +72、无 FR 率增加了 +83，这与"质量优先"分配逻辑不一致。</p>
<p><strong>3. 驾驭卡合规影响集中：</strong><br/>
驾驭卡 0-50% 的合作商（44 个）合计贡献 -280 净变化，超过高合规区间带来的正向增益。</p>
<p><strong>可能解释：</strong><br/>
• 低绩效、低 FR 合作商可能处于新合作商爬坡支持期<br/>
• 高绩效合作商可能在 1 月被过度分配，并在 2 月回调<br/>
• 手动调整中，驾驭卡合规门槛可能覆盖绩效指标<br/>
• 需交叉验证："待改善"合作商是否同时属于"新合作商"且驾驭卡较低？</p>
</div>'

$newCounterBody = '<div data-i18n-html="adj-counterintuitive-body" style="color: #6b21a8; font-size: 14px; line-height: 1.8;">
<p><strong>1. "Bad" Quarterly Performance Partners Still Net Positive:</strong><br/>
25 partners classified as "Bad" received +117 net riders (avg +4.7), while "Good" partners net -348 (avg -8.1).</p>
<p><strong>2. FR Misalignment with Allocation Outcome:</strong><br/>
High FR (80-100%) took -322 net reduction while 70-80% gained +72 and No-FR gained +83, inconsistent with "quality-first" allocation logic.</p>
<p><strong>3. Driver Card Compliance Impact Concentrated:</strong><br/>
Driver card 0-50% partners (44) contributed -280 net change combined, exceeding positive gains from high compliance bands.</p>
<p><strong>Possible Explanations:</strong><br/>
• Low performance/FR partners may be in new partner ramp-up support period<br/>
• High performance partners may have been over-allocated in Jan and corrected in Feb<br/>
• Driver card compliance threshold may override performance metrics in manual adjustments<br/>
• Need to cross-validate: Are "Bad" partners also "New" partners with low driver cards?</p>
</div>'

$content = $content.Replace($oldCounterBody, $newCounterBody)

# Fix adj-strategic-insight-grid (restore English inside this data-i18n-html block)
# Find and replace opening section
$content = $content.Replace(
    '<h4 style="color: #dc2626; margin-bottom: 15px; font-size: 16px;">1️⃣ 司机卡合规压力（37.7%）</h4>',
    '<h4 style="color: #dc2626; margin-bottom: 15px; font-size: 16px;">1️⃣ Driver Card Compliance Crisis (37.7%)</h4>'
)
$content = $content.Replace(
    '<strong>61 个合作商中有 23 个被调整</strong>，原因是司机卡可用性问题。这已成为 2 月主导因素，取代 1 月以绩效为主的调整逻辑，反映出运营优先级变化。',
    '<strong>23 of 61 partners adjusted</strong> due to driver card availability issues. This became the dominant factor in February, replacing January''s performance-based adjustment logic, reflecting an operational priority shift.'
)
$content = $content.Replace(
    '<h4 style="color: #10b981; margin-bottom: 15px; font-size: 16px;">2️⃣ 显著产能收缩（-8.6%）</h4>',
    '<h4 style="color: #10b981; margin-bottom: 15px; font-size: 16px;">2️⃣ Significant Capacity Contraction (-8.6%)</h4>'
)
$content = $content.Replace(
    '<strong>净变化 -173 名骑手（-8.6%）</strong>，对比 1 月的 +25。27 个合作商增加 +423，34 个合作商减少 -596，体现出更紧的产能管理与绩效筛选。',
    '<strong>Net change -173 riders (-8.6%)</strong> vs January''s +25. 27 partners gained +423 while 34 partners lost -596, reflecting tighter capacity management and quality screening.'
)
$content = $content.Replace(
    '<h4 style="color: #f59e0b; margin-bottom: 15px; font-size: 16px;">3️⃣ 合规驱动调整（50.8%）</h4>',
    '<h4 style="color: #f59e0b; margin-bottom: 15px; font-size: 16px;">3️⃣ Compliance-Driven Adjustments (50.8%)</h4>'
)
$content = $content.Replace(
    '<strong>司机卡（37.7%）+ FR/绩效（13.1%）</strong>合计占调整的 50.8%。合规已成为主要调整驱动，战略性分配（缓冲、新合作商、产能转移）占 26.2%。',
    '<strong>Driver Card (37.7%) + FR/Performance (13.1%)</strong> combine for 50.8% of adjustments. Compliance has become the primary adjustment driver, while strategic allocations (buffer, new partners, transfers) account for 26.2%.'
)
$content = $content.Replace(
    '<h4 style="color: #8b5cf6; margin-bottom: 15px; font-size: 16px;">4️⃣ 城市集中度</h4>',
    '<h4 style="color: #8b5cf6; margin-bottom: 15px; font-size: 16px;">4️⃣ City Concentration Risk</h4>'
)
$content = $content.Replace(
    '两座城市贡献了 78.7% 的合作商与主要净削减；较小城市（Tabuk、Taif、Madinah、Jubail、Al Ahsa、Jazan）呈现净增长。',
    'Two cities account for 78.7% of partners and primary net reductions. Smaller cities (Tabuk, Taif, Madinah, Jubail, Al Ahsa, Jazan) all show net growth.'
)
$content = $content.Replace(
    '<h4 style="color: #3b82f6; margin-bottom: 15px; font-size: 16px;">5️⃣ 老合作商产能收缩</h4>',
    '<h4 style="color: #3b82f6; margin-bottom: 15px; font-size: 16px;">5️⃣ Old Partners Capacity Contraction</h4>'
)
$content = $content.Replace(
    '<strong>40 个老合作商净减少 -311 名骑手</strong>，而 13 个新合作商净增加 +55。成熟合作商面临更严格合规执行，新合作商则获得爬坡支持。',
    '<strong>40 old partners net -311 riders</strong> while 13 new partners net +55. Established partners face stricter compliance enforcement while new partners receive ramp-up support.'
)
$content = $content.Replace(
    '<h4 style="color: #ec4899; margin-bottom: 15px; font-size: 16px;">6️⃣ 组合精简</h4>',
    '<h4 style="color: #ec4899; margin-bottom: 15px; font-size: 16px;">6️⃣ Portfolio Optimization</h4>'
)
$content = $content.Replace(
    '<strong>调整合作商数量减少 50.4%</strong>（61 对比 1 月 123）。说明干预更聚焦，或合作商基盘收缩；单合作商平均调整影响为 -3.5，对比 1 月 +0.2。',
    '<strong>50.4% fewer partners adjusted</strong> (61 vs January''s 123). Indicates more focused intervention or a contracting partner base. Average adjustment impact per partner: -3.5 vs January''s +0.2.'
)

# Fix the reason segment table in adjustment tab
$content = $content.Replace('>📋 细分选择的原因<', '>📋 Reason Segment Selection<')

Set-Content $file -Value $content -Encoding UTF8 -NoNewline
Write-Host "All fixes applied!"
