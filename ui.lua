local UILibrary = {}

-- Function to create the main window
function UILibrary:CreateWindow(props)
    local Window = {
        Title = props.Title or "Default Title",
        Size = props.Size or UDim2.new(0, 600, 0, 450),
        Pages = {},
    }

    -- Create the GUI
    local ScreenGui = Instance.new('ScreenGui', game.CoreGui)
    local WindowFrame = Instance.new('Frame', ScreenGui)

    -- Basic window setup
    WindowFrame.Size = Window.Size
    WindowFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
    WindowFrame.AnchorPoint = Vector2.new(0.5, 0.5)
    WindowFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    WindowFrame.BorderSizePixel = 0

    -- Title bar
    local TitleBar = Instance.new('TextLabel', WindowFrame)
    TitleBar.Text = Window.Title
    TitleBar.Size = UDim2.new(1, 0, 0, 40)
    TitleBar.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    TitleBar.TextColor3 = Color3.fromRGB(255, 255, 255)
    TitleBar.Font = Enum.Font.Gotham
    TitleBar.TextSize = 14

    -- Store references
    Window.GUI = ScreenGui
    Window.MainFrame = WindowFrame

    -- Return window object for further modification
    return Window
end

-- Function to add pages (like tabs)
function UILibrary:CreatePage(window, props)
    local Page = {
        Name = props.Name or "Page",
        Sections = {}
    }

    -- Create a button for this page (tab)
    local PageButton = Instance.new('TextButton', window.MainFrame)
    PageButton.Size = UDim2.new(0, 100, 0, 30)
    PageButton.Text = Page.Name
    PageButton.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    PageButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    PageButton.Font = Enum.Font.Gotham
    PageButton.TextSize = 12

    -- Return the page object
    window.Pages[#window.Pages + 1] = Page
    return Page
end

-- Function to add sections inside pages
function UILibrary:CreateSection(page, props)
    local Section = {
        Name = props.Name or "Section",
        Elements = {}
    }

    -- Section setup
    local SectionFrame = Instance.new('Frame', page.MainFrame)
    SectionFrame.Size = UDim2.new(1, -10, 0, 200)
    SectionFrame.BackgroundColor3 = Color3.fromRGB(50, 50, 50)

    -- Title
    local SectionTitle = Instance.new('TextLabel', SectionFrame)
    SectionTitle.Text = Section.Name
    SectionTitle.Size = UDim2.new(1, 0, 0, 25)
    SectionTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
    SectionTitle.BackgroundTransparency = 1
    SectionTitle.Font = Enum.Font.Gotham
    SectionTitle.TextSize = 12

    page.Sections[#page.Sections + 1] = Section
    return Section
end

-- Adding a button to the UI
function UILibrary:CreateButton(section, props)
    local Button = {
        Text = props.Text or "Button",
        Callback = props.Callback or function() end
    }

    -- Create the button element
    local ButtonElement = Instance.new('TextButton', section.MainFrame)
    ButtonElement.Size = UDim2.new(1, 0, 0, 30)
    ButtonElement.Text = Button.Text
    ButtonElement.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    ButtonElement.TextColor3 = Color3.fromRGB(255, 255, 255)
    ButtonElement.Font = Enum.Font.Gotham
    ButtonElement.TextSize = 12

    -- Connect the callback
    ButtonElement.MouseButton1Click:Connect(function()
        Button.Callback()
    end)

    -- Return the button object
    section.Elements[#section.Elements + 1] = Button
    return Button
end

-- Adding a toggle switch
function UILibrary:CreateToggle(section, props)
    local Toggle = {
        Text = props.Text or "Toggle",
        State = props.State or false,
        Callback = props.Callback or function() end
    }

    -- Create the toggle element
    local ToggleElement = Instance.new('TextButton', section.MainFrame)
    ToggleElement.Size = UDim2.new(1, 0, 0, 30)
    ToggleElement.Text = Toggle.Text .. ": " .. (Toggle.State and "ON" or "OFF")
    ToggleElement.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    ToggleElement.TextColor3 = Color3.fromRGB(255, 255, 255)
    ToggleElement.Font = Enum.Font.Gotham
    ToggleElement.TextSize = 12

    -- Toggle behavior
    ToggleElement.MouseButton1Click:Connect(function()
        Toggle.State = not Toggle.State
        ToggleElement.Text = Toggle.Text .. ": " .. (Toggle.State and "ON" or "OFF")
        Toggle.Callback(Toggle.State)
    end)

    -- Return the toggle object
    section.Elements[#section.Elements + 1] = Toggle
    return Toggle
end

return UILibrary
