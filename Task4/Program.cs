using System.Collections;

public class SmartStack<T> : IEnumerable<T>, IEnumerable
{
    private T[] _item;
    private int _size;

    public SmartStack()
    {
        _item = new T[4];
        _size = 0;
    }

    public SmartStack(int capacity)
    {
        if (capacity < 0)
        {
            throw new ArgumentOutOfRangeException(nameof(capacity), "Емкость не может быть отрицательной");
        }

        _item = new T[capacity];
        _size = 0;
    }

    public SmartStack(IEnumerable<T> collection)
    {
        if (collection == null)
        {
            throw new ArgumentNullException(nameof(collection));
        }

        if (collection is ICollection<T> col)
        {
            int count = col.Count;
            _item = new T[count == 0 ? 4 : col.Count];
            _size = 0;

            foreach (var item in col)
            {
                _item[_size++] = item;
            }
        }
        else
        {
            _item = new T[4];
            _size = 0;
            foreach (var item in collection)
            {
                Push(item);
            }
        }
    }

    public void Push(T item)
    {
        if (_size == _item.Length)
        {
            Resize(_item.Length == 0 ? 4 : _item.Length * 2);
        }
        _item[_size++] = item;
    }

    public void PushRange(IEnumerable<T> collection)
    {
        if (collection == null)
        {
            throw new ArgumentNullException(nameof(collection));
        }

        if (collection is ICollection<T> col)
        {
            int neededCapacity = col.Count + _size;
            if (neededCapacity > _item.Length)
            {
                int newCapacity = _item.Length == 0 ? 4 : _item.Length;
                while (neededCapacity > newCapacity)
                {
                    newCapacity *= 2;
                }
                Resize(newCapacity);
            }
            foreach (var item in col)
            {
                _item[_size++] = item;
            }
        }
        else
        {
            foreach (var item in collection)
            {
                Push(item);
            }
        }
    }

    public T Pop()
    {
        if (_size == 0)
        {
            throw new InvalidOperationException("Стек пуст, невозможно выполнить Pop.");
        }

        _size--;
        T item = _item[_size];
        _item[_size] = default(T);

        return item;
    }

    public T Peek()
    {
        if (_size == 0)
        {
            throw new InvalidOperationException("Стек пуст, невозможно выполнить Peek.");
        }
        return _item[_size - 1];
    }

    public bool Contains(T item)
    {
        var comparer = EqualityComparer<T>.Default;
        for (int i = 0; i < _size; i++)
        {
            if (comparer.Equals(item, _item[i]))
                return true;
        }
        return false;
    }

    public int Count => _size;
    public int Capacity => _item.Length;

    public T this[int index]
    {
        get
        {
            if (index < 0 || index >= _size)
            {
                throw new ArgumentOutOfRangeException(nameof(index), "Индекс выходит за границы стека.");
            }
            return _item[_size - 1 - index];
        }
    }

    public IEnumerator<T> GetEnumerator()
    {
        for (int i = _size - 1; i >= 0; i--)
        {
            yield return _item[i];
        }
    }
    IEnumerator IEnumerable.GetEnumerator()
    {
        return GetEnumerator();
    }

    private void Resize(int newCapacity)
    {
        T[] newArray = new T[newCapacity];

        for (int i = 0; i < _size; i++)
        {
            newArray[i] = _item[i];
        }
        _item = newArray;
    }
}

public class Program
{
    public static void Main()
    {
        var stack = new SmartStack<int>(new[] { 1, 2, 3 });

        stack.Push(4);
        stack.PushRange(new List<int> { 5, 6 });

        Console.WriteLine($"Количество элементов: {stack.Count}");
        Console.WriteLine($"Текущая емкость массива: {stack.Capacity}");

        Console.WriteLine("\nОбход массива от вершины к основанию:");
        foreach (var item in stack)
        {
            Console.Write(item + " ");
        }
        Console.WriteLine();

        Console.WriteLine($"Элемент на глубине 0: {stack[0]}");
        Console.WriteLine($"Элемент на глубине 2: {stack[2]}");

        Console.WriteLine($"Извлекаем из стека (Pop): {stack.Pop()}");
        Console.WriteLine($"Смотрим новую вершину (Peek): {stack.Peek()}");
    }
}
