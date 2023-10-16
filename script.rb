class Node
    attr_accessor(:data, :left, :right)

    def initialize(data, left = nil, right = nil)
        @data = data
        @left = left
        @right = right
    end
end

class Tree
    attr_accessor :root

    def initialize(array)
        @root = build_tree(array)
    end

    def build_tree(array)
        array = array.uniq.sort
        return nil if array.empty?

        mid = array.length / 2
        root = Node.new(array[mid])
        root.left = build_tree(array[0...mid])
        root.right = build_tree(array[mid + 1..-1])

        root
    end

    def insert(value)
        return @root = Node.new(value) if @root.nil?

        current_node = @root
        new_node = Node.new(value)

        while (current_node)
            if (current_node.left && value < current_node.data)
                current_node = current_node.left
            elsif (current_node.right && value > current_node.data)
                current_node = current_node.right
            else
                break
            end
        end

        if (value < current_node.data)
            current_node.left = new_node
        elsif (value > current_node.data)
            current_node.right = new_node
        end

        new_node
    end

    def find(value)
        return if @root.nil?
        return @root if @root.data == value

        current_node = @root

        while (current_node)
            if (current_node.left && value < current_node.data)
                current_node = current_node.left
            elsif (current_node.right && value > current_node.data)
                current_node = current_node.right
            elsif (value == current_node.data)
                return current_node
            else
                break
            end
        end
    end

    def height
        return height_recursive(@root)
    end

    # Recursive helper method to calculate the height
    def height_recursive(node)
        return 0 if node.nil?

        left_height = height_recursive(node.left)
        right_height = height_recursive(node.right)

        p [left_height, right_height]

        # The height of the tree is the maximum of the left and right subtrees plus 1 for the current node.
        return [left_height, right_height].max + 1
    end

    def rebalance
        return if height < 3
    end

    def pretty_print(node = @root, prefix = '', is_left = true)
        return if node.nil?

        pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
        puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
        pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
    end
end

array = [1, 7, 4, 23, 8, 9, 4, 3, 5, 7, 9, 67, 6345, 324]
# array = [1, 2, 3, 4, 5, 6, 7 ,8 ,9 , 10]
tree = Tree.new(array)

tree.insert(6)
tree.insert(2)
tree.insert(0)
tree.insert(10)
tree.insert(11)
tree.insert(12)
tree.insert(13)
tree.insert(21)
tree.insert(30)
tree.insert(29)
tree.insert(33)

# p tree.find(1)
p "Tree Height: #{tree.height}"


puts
puts


tree.pretty_print
